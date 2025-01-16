import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());
  final _apiService = getIt.get<ApiService>();

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    try {
      await _apiService.post('auth/delete-account', data: {
        'email': SalonsUserCubit.user.email,
        'method': 'email',
      });
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountFailed(errMessage: e.toString()));
    }
  }
}
