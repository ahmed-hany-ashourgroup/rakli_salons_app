import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/data/models/models/search_results_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  final ApiService _apiService = getIt.get<ApiService>();

  Future<void> search({
    String? query,
    required String category,
    int? minPrice,
    int? maxPrice,
    int? rating,
    List<int>? sortOptions,
  }) async {
    emit(SearchLoading());

    try {
      final Map<String, dynamic> queryParams = {
        if (query != null) 'query': query,
        'category': category,
        if (minPrice != null) 'price_min': minPrice,
        if (maxPrice != null) 'price_max': maxPrice,
        if (rating != null) 'rating': rating,
        if (sortOptions != null && sortOptions.isNotEmpty)
          'sort_options': sortOptions.join(','),
      };

      final response = await _apiService.get(
        'search',
        queryParameters: queryParams,
      );

      if (response == null) {
        emit(SearchFailed(errMessage: 'No response from server'));
        return;
      }

      if (response['success'] == true && response['data'] != null) {
        final searchResults = SearchResults.fromJson(response, category);
        emit(SearchSuccess(results: searchResults));
      } else {
        emit(SearchFailed(errMessage: response['message'] ?? 'Search failed'));
      }
    } catch (e) {
      Logger.error('Error: $e');
      emit(SearchFailed(
          errMessage: _apiService.handleDioError(e.toString()).message));
    }
  }
}
