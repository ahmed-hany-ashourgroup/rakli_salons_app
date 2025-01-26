part of 'salon_wish_list_cubit.dart';

sealed class SalonWishListState extends Equatable {
  const SalonWishListState();

  @override
  List<Object> get props => [];
}

final class SalonWishListInitial extends SalonWishListState {}

final class SalonWishListLoading extends SalonWishListState {}

final class SalonWishListSuccess extends SalonWishListState {}

final class SalonWishListLoaded extends SalonWishListState {
  final List<SalonModel> salons;

  const SalonWishListLoaded(this.salons);

  @override
  List<Object> get props => [salons];
}

final class SalonWishListFailed extends SalonWishListState {
  final String errMessage;
  const SalonWishListFailed({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
