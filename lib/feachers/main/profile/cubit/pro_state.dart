part of 'pro_cubit.dart';

@immutable
abstract class ProState {}

class ProInitial extends ProState {}

class EditProfileState extends ProState {}

class SaveUserDataState extends ProState {}

class TabIndexState extends ProState {}