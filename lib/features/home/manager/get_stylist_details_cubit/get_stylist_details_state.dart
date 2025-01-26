part of 'get_stylist_details_cubit.dart';

sealed class GetStylistDetailsState {}

final class GetStylistDetailsInitial extends GetStylistDetailsState {}

final class GetStylistDetailsLoading extends GetStylistDetailsState {}

final class GetStylistDetailsSuccess extends GetStylistDetailsState {
  final StylistModel stylist;

  GetStylistDetailsSuccess({required this.stylist});
}

final class GetStylistDetailsFailed extends GetStylistDetailsState {
  final String errMessage;
  GetStylistDetailsFailed({required this.errMessage});
}
