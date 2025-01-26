part of 'get_nearby_salons_cubit.dart';

sealed class GetNearbySalonsState extends Equatable {
  const GetNearbySalonsState();

  @override
  List<Object> get props => [];
}

final class GetNearbySalonsInitial extends GetNearbySalonsState {}

final class GetNearbySalonsLoading extends GetNearbySalonsState {}

final class GetNearbySalonsSuccess extends GetNearbySalonsState {
  final List<SalonModel> salons;

  const GetNearbySalonsSuccess({required this.salons});
}

final class GetNearbySalonsFailed extends GetNearbySalonsState {
  final String errMessage;

  const GetNearbySalonsFailed({required this.errMessage});
}
