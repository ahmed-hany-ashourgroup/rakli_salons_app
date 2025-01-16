part of 'get_services_cubit.dart';

@immutable
sealed class GetServicesState {}

final class GetServicesInitial extends GetServicesState {}

final class GetServicesLaoding extends GetServicesState {}

final class GetServicesSuccess extends GetServicesState {
  List<String> services;

  GetServicesSuccess({required this.services});
}

final class GetServicesFailed extends GetServicesState {
  final String errMessage;

  GetServicesFailed({required this.errMessage});
}
