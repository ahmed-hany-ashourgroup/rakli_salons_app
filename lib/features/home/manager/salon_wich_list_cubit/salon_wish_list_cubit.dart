import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/salon_model.dart';

part 'salon_wish_list_state.dart';

class SalonWishListCubit extends Cubit<SalonWishListState> {
  SalonWishListCubit() : super(SalonWishListInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> addSalonsToWishlist(List<int> salonIds) async {
    emit(SalonWishListLoading());
    try {
      final response = await _apiService.post(
        'wishlist-salon/add',
        data: {
          'salon_ids': salonIds,
        },
      );

      if (response['success'] == true) {
        emit(SalonWishListSuccess());
      } else {
        emit(SalonWishListFailed(errMessage: response['message']));
      }
    } catch (e) {
      emit(SalonWishListFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> getSalonsWishlist() async {
    emit(SalonWishListLoading());
    try {
      final response = await _apiService.get('wishlist-salon');

      if (response['success'] == true) {
        final List<dynamic> wishlistData = response['data'];

        // Check if the wishlist data contains salons
        if (wishlistData.isNotEmpty) {
          final List<SalonModel> salons = wishlistData
              .where(
                  (item) => item['salons'] != null && item['salons'].isNotEmpty)
              .map((item) => SalonModel.fromJson(item['salons'][0]))
              .toList();

          if (salons.isNotEmpty) {
            emit(SalonWishListLoaded(salons));
          } else {
            emit(
                SalonWishListFailed(errMessage: 'No salons found in wishlist'));
          }
        } else {
          emit(SalonWishListFailed(errMessage: 'Wishlist is empty'));
        }
      } else {
        emit(SalonWishListFailed(
            errMessage: response['message'] ?? 'Failed to fetch wishlist'));
      }
    } catch (e) {
      emit(SalonWishListFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
