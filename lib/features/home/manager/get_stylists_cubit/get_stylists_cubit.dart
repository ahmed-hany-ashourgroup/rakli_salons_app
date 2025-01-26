import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/stylist_model.dart';

part 'get_stylists_state.dart';

class GetStylistsCubit extends Cubit<GetStylistsState> {
  GetStylistsCubit() : super(GetStylistsInitial());
  final _apiService = getIt.get<ApiService>();

  Future<void> getAllStylists() async {
    emit(GetStylistsLoading());
    try {
      final response = await _apiService.get('business/get/freelancers');

      // Extract the 'data' field from the response
      final List<dynamic> data = response['data'];

      // Convert each item in 'data' to a StylistModel object
      final List<StylistModel> stylists =
          data.map((json) => StylistModel.fromJson(json)).toList();

      emit(GetStylistsSuccess(stylists: stylists));
    } catch (e) {
      emit(GetStylistsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }

  Future<void> getTopRatedStylists() async {
    emit(GetStylistsLoading());
    try {
      final response =
          await _apiService.get('businesses/top-rated/freelancers');

      // Extract the 'data' field from the response
      final List<dynamic> data = response['data'];

      // Convert each item in 'data' to a StylistModel object
      final List<StylistModel> stylists =
          data.map((json) => StylistModel.fromJson(json)).toList();

      emit(GetStylistsSuccess(stylists: stylists));
    } catch (e) {
      emit(GetStylistsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
