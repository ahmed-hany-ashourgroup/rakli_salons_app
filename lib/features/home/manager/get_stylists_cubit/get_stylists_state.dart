part of 'get_stylists_cubit.dart';

@immutable
sealed class GetStylistsState {}

final class GetStylistsInitial extends GetStylistsState {}

final class GetStylistsLoading extends GetStylistsState {}

final class GetStylistsSuccess extends GetStylistsState {
  final List<StylistModel> stylists;
  GetStylistsSuccess({required this.stylists});
}

final class GetStylistsFailed extends GetStylistsState {
  final String errMessage;
  GetStylistsFailed({required this.errMessage});
}
