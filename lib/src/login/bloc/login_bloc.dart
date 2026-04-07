import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/models/login_model.dart';
import 'package:gb_lottery_b2b/src/login/repo/login_repository.dart';
import 'package:logger/logger.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(LoginState.initial) {
    on<ToggleLoginMode>(_onToggleMode);
    on<UpdateMobileNumber>(_onUpdateMobile);
    on<UpdateOtpNumber>(_onUpdateOtp);
    on<UpdatePasswordString>(_onUpdatePassword);
    on<RequestLoginOtp>(_onRequestOtp);
    on<SubmitLoginCredentials>(_onSubmitLogin);
    on<ResetLoginMessage>(_onReset);
  }

  final LoginRepository _repository;
  final _log = Logger();

  void _onToggleMode(ToggleLoginMode event, Emitter<LoginState> emit) {
    emit(state.copyWith(isOtpLogin: () => event.isOtpMode));
  }

  void _onUpdateMobile(UpdateMobileNumber event, Emitter<LoginState> emit) {
    emit(state.copyWith(mobile: () => event.mobile));
  }

  void _onUpdateOtp(UpdateOtpNumber event, Emitter<LoginState> emit) {
    emit(state.copyWith(otp: () => event.otp));
  }

  void _onUpdatePassword(UpdatePasswordString event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: () => event.password));
  }

  Future<void> _onRequestOtp(
    RequestLoginOtp event,
    Emitter<LoginState> emit,
  ) async {
    _log.d('LoginBloc::_onRequestOtp::Requesting OTP for ${state.mobile}');
    try {
      emit(state.copyWith(status: () => LoginStatus.loading));
      await _repository.requestOtp(mobile: state.mobile);
      emit(
        state.copyWith(
          status: () => LoginStatus.otpRequested,
          message: () => 'OTP sent successfully',
        ),
      );
      emit(state.copyWith(status: () => LoginStatus.loaded));
    } catch (e) {
      _log.e('LoginBloc::_onRequestOtp::Error: $e');
      emit(
        state.copyWith(
          status: () => LoginStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onSubmitLogin(
    SubmitLoginCredentials event,
    Emitter<LoginState> emit,
  ) async {
    _log.d('LoginBloc::_onSubmitLogin::Submitting login');
    try {
      emit(
        state.copyWith(
          status: () => LoginStatus.submitting,
          message: () => '',
        ),
      );

      final LoginModel user;
      if (state.isOtpLogin) {
        user = await _repository.loginWithOtp(
          mobile: state.mobile,
          otp: state.otp,
        );
      } else {
        user = await _repository.loginWithPassword(
          mobile: state.mobile,
          password: state.password,
        );
      }

      emit(
        state.copyWith(
          status: () => LoginStatus.success,
          user: () => user,
          message: () => 'Login successful',
        ),
      );
    } catch (e) {
      _log.e('LoginBloc::_onSubmitLogin::Error: $e');
      emit(
        state.copyWith(
          status: () => LoginStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  void _onReset(ResetLoginMessage event, Emitter<LoginState> emit) {
    emit(state.copyWith(message: () => ''));
  }
}
