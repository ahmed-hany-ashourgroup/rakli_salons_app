part of 'update_profile_cubit.dart';

@immutable
abstract class UpdateProfileState {}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileLoading extends UpdateProfileState {}

class UpdateProfileSuccess extends UpdateProfileState {
  final BuisnessUserModel user;

  UpdateProfileSuccess({required this.user});
}

class UpdateProfileFailed extends UpdateProfileState {
  final String errMessage;

  UpdateProfileFailed({required this.errMessage});
}
