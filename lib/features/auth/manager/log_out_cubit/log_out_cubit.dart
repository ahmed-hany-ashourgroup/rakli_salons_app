import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  final _apiService = getIt.get<ApiService>();

  Future<void> logOut() async {
    try {
      emit(LogOutLoading());
      await _apiService.post('auth/logout');
      emit(LogOutSuccess());
    } catch (e) {
      emit(LogOutFailed(errMessage: e.toString()));
    }
  }
}
