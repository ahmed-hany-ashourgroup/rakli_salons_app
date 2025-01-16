import 'package:get_it/get_it.dart';
import 'package:rakli_salons_app/core/utils/api_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(),
  );
}
