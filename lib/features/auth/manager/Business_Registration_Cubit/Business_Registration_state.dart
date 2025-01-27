// business_registration_state.dart

import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';

abstract class BusinessRegistrationState {}

class BusinessRegistrationInitial extends BusinessRegistrationState {}

class BusinessRegistrationLoading extends BusinessRegistrationState {}

class BusinessRegistrationSuccess extends BusinessRegistrationState {
  final BuisnessUserModel user;
  BusinessRegistrationSuccess({required this.user});
}

class BusinessRegistrationFailed extends BusinessRegistrationState {
  final String errMessage;
  BusinessRegistrationFailed({required this.errMessage});
}
