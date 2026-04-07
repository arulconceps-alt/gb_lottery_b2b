part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ToggleLoginMode extends LoginEvent {
  final bool isOtpMode;
  const ToggleLoginMode(this.isOtpMode);

  @override
  List<Object> get props => [isOtpMode];
}

class UpdateMobileNumber extends LoginEvent {
  final String mobile;
  const UpdateMobileNumber(this.mobile);

  @override
  List<Object> get props => [mobile];
}

class UpdateOtpNumber extends LoginEvent {
  final String otp;
  const UpdateOtpNumber(this.otp);

  @override
  List<Object> get props => [otp];
}

class UpdatePasswordString extends LoginEvent {
  final String password;
  const UpdatePasswordString(this.password);

  @override
  List<Object> get props => [password];
}

class RequestLoginOtp extends LoginEvent {
  const RequestLoginOtp();
}

class SubmitLoginCredentials extends LoginEvent {
  const SubmitLoginCredentials();
}

class ResetLoginMessage extends LoginEvent {
  const ResetLoginMessage();
}
