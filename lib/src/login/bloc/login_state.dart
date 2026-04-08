part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  loaded,
  failure,
  submitting,
  success,
  otpRequested,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final bool isOtpLogin;
  final String mobile;
  final String otp;
  final String password;
  final String message;
  final LoginModel? user;

  const LoginState({
    required this.status,
    required this.isOtpLogin,
    required this.mobile,
    required this.otp,
    required this.password,
    required this.message,
    this.user,
  });

  static const LoginState initial = LoginState(
    status: LoginStatus.initial,
    isOtpLogin: true,
    mobile: '9876543210',
    otp: '123456',
    password: '',
    message: '',
    user: null,
  );

  LoginState copyWith({
    LoginStatus Function()? status,
    bool Function()? isOtpLogin,
    String Function()? mobile,
    String Function()? otp,
    String Function()? password,
    String Function()? message,
    LoginModel? Function()? user,
  }) {
    return LoginState(
      status: status != null ? status() : this.status,
      isOtpLogin: isOtpLogin != null ? isOtpLogin() : this.isOtpLogin,
      mobile: mobile != null ? mobile() : this.mobile,
      otp: otp != null ? otp() : this.otp,
      password: password != null ? password() : this.password,
      message: message != null ? message() : this.message,
      user: user != null ? user() : this.user,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isOtpLogin,
        mobile,
        otp,
        password,
        message,
        user,
      ];
}
