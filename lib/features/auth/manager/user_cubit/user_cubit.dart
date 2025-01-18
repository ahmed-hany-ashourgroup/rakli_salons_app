import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';

part 'user_state.dart';

class SalonsUserCubit extends Cubit<UserState> {
  SalonsUserCubit() : super(UserInitial());
  static SalonUserModel user = SalonUserModel();
}
