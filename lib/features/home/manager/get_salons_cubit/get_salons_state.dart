part of 'get_salons_cubit.dart';

@immutable
sealed class GetSalonsState {}

final class GetSalonsInitial extends GetSalonsState {}

final class GetSalonsLoading extends GetSalonsState {}

final class GetSalonsSuccess extends GetSalonsState {
  final List<SalonModel> salons;

  GetSalonsSuccess({required this.salons});
}

final class GetSalonsFailed extends GetSalonsState {
  final String errMessage;
  GetSalonsFailed({required this.errMessage});
}
