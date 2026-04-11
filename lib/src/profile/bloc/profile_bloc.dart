import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/common/models/agent_model.dart';
import 'package:gb_lottery_b2b/src/profile/repo/profile_repository.dart';
import 'package:logger/logger.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final _log = Logger();

  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileState.initial) {
    on<FetchProfile>(_onFetchProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onFetchProfile(
    FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    _log.d('ProfileBloc::_onFetchProfile::Fetching profile');
    try {
      emit(state.copyWith(status: () => ProfileStatus.loading));
      final user = await _repository.getProfile();
      emit(
        state.copyWith(
          status: () => ProfileStatus.loaded,
          user: () => user,
        ),
      );
    } catch (e) {
      _log.e('ProfileBloc::_onFetchProfile::Error: $e');
      emit(
        state.copyWith(
          status: () => ProfileStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfile event,
    Emitter<ProfileState> emit,
  ) async {
    _log.d('ProfileBloc::_onUpdateProfile::Updating profile');
    try {
      emit(state.copyWith(status: () => ProfileStatus.updating));
      final user = await _repository.updateProfile(
        name: event.name,
        email: event.email,
        phone: event.phone,
      );
      emit(
        state.copyWith(
          status: () => ProfileStatus.updateSuccess,
          user: () => user,
        ),
      );
    } catch (e) {
      _log.e('ProfileBloc::_onUpdateProfile::Error: $e');
      emit(
        state.copyWith(
          status: () => ProfileStatus.failure,
          message: () => e.toString(),
        ),
      );
    }
  }
}
