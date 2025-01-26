import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/ads_model.dart';

part 'get_ads_state.dart';

class GetAdsCubit extends Cubit<GetAdsState> {
  GetAdsCubit() : super(GetAdsInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> getAds() async {
    emit(GetAdsLoading());
    try {
      final response = await _apiService.get('ads');
      Logger.info(
          'Response: $response'); // Log the response to confirm structure

      if (response['data'] != null && response['data'] is List) {
        final List<AdsModel> ads = (response['data'] as List)
            .map((ad) => AdsModel.fromJson(ad))
            .toList();
        Logger.info('Ads: $ads');
        emit(GetAdsSuccess(ads: ads));
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e, stackTrace) {
      Logger.error('Error: $e');
      Logger.error('StackTrace: $stackTrace');
      emit(GetAdsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
