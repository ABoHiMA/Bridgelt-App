abstract class LoginStates{}

class LoginInitState extends LoginStates{}

class LoginPassVisibleState extends LoginStates{}

class LoginLoadingState extends LoginStates {}

class LoginSuccState extends LoginStates {
  final String uId;
  LoginSuccState(this.uId);
}

class LoginErrState extends LoginStates {
  final String error;
  LoginErrState(this.error);
}



