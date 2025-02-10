part of 'delete_service_cubit.dart';

@immutable
abstract class DeleteServiceState {}

class DeleteServiceInitial extends DeleteServiceState {}

class DeleteServiceLoading extends DeleteServiceState {}

class DeleteServiceSuccess extends DeleteServiceState {}

class DeleteServiceFailed extends DeleteServiceState {
  final String errMessage;

  DeleteServiceFailed({required this.errMessage});
}
