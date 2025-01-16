import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/errors/failure.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'get_services_state.dart';

class GetServicesCubit extends Cubit<GetServicesState> {
  GetServicesCubit() : super(GetServicesInitial());
  final ApiService _apiService = getIt.get<ApiService>();
  Future<Either<Failure, List<String>>> getServices() async {
    emit(GetServicesLaoding());
    try {
      final response = await _apiService.get('preferences/get');
      emit(GetServicesSuccess(services: response));
      return Right(response);
    } catch (e) {
      emit(GetServicesFailed(errMessage: e.toString()));
      return Left(Failure(e.toString()));
    }
  }
}
