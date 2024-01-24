part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class SuccessMealState extends LoginState {}

class LodingState extends LoginState{}

class SuccessGetStartState extends LoginState {}

class loadingState extends LoginState {}

class ChangeState extends LoginState {}

class GetUserDataState extends LoginState {}

class GetProfileState extends LoginState {}

class Changeobscurypass extends LoginState {}

class Changeobscurycon extends LoginState {}

class finduserstate extends LoginState {}

class setDataprofileState extends LoginState {}

class SuccessLogInState extends LoginState {}
