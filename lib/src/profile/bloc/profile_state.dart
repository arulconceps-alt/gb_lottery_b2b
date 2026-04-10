part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, loaded, failure, updating, updateSuccess }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final AgentModel user;
  final String message;

  const ProfileState({
    required this.status,
    required this.user,
    required this.message,
  });

  static ProfileState initial = ProfileState(
    status: ProfileStatus.initial,
    user: AgentModel.empty(),
    message: '',
  );

  ProfileState copyWith({
    ProfileStatus Function()? status,
    AgentModel Function()? user,
    String Function()? message,
  }) {
    return ProfileState(
      status: status != null ? status() : this.status,
      user: user != null ? user() : this.user,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [status, user, message];
}
