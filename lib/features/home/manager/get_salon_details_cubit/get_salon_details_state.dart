part of 'get_salon_details_cubit.dart';

abstract class GetSalonDetailsState extends Equatable {
  const GetSalonDetailsState();

  @override
  List<Object> get props => [];
}

class GetSalonDetailsInitial extends GetSalonDetailsState {}

class GetSalonDetailsLoading extends GetSalonDetailsState {}

class GetSalonDetailsSuccess extends GetSalonDetailsState {
  final SalonModel salon; // Add this property

  const GetSalonDetailsSuccess(this.salon);

  @override
  List<Object> get props => [salon];
}

class GetSalonDetailsFailed extends GetSalonDetailsState {
  final String errMessage;

  const GetSalonDetailsFailed(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
