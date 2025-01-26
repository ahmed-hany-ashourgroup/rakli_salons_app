import 'package:bloc/bloc.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/stylist_model.dart';

part 'get_stylist_details_state.dart';

class GetStylistDetailsCubit extends Cubit<GetStylistDetailsState> {
  GetStylistDetailsCubit() : super(GetStylistDetailsInitial()) {
    // Initialize with loading state
    emit(GetStylistDetailsLoading());
  }

  final _apiService = getIt<ApiService>();

  Future<void> getStylistDetails(String stylistId) async {
    emit(GetStylistDetailsLoading());
    try {
      final response = await _apiService.get('business/$stylistId');
      final stylist = StylistModel.fromJson(response['data']);
      emit(GetStylistDetailsSuccess(stylist: stylist));
    } catch (e) {
      emit(GetStylistDetailsFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
