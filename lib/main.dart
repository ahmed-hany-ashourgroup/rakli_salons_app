import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/errors/simple_bloc_observer.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/manager/log_out_cubit/log_out_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/check_out_cubit/check_out_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/filter_cubit/filter_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_cart_items_cubit/get_cart_items_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/search_cubit/search_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AddToCartCubit(),
      ),
      BlocProvider(
        create: (context) => FilterCubit(),
      ),
      BlocProvider(
        create: (context) => CheckOutCubit(),
      ),
      BlocProvider(
        create: (context) => SearchCubit(),
      ),
      BlocProvider(
        create: (context) => LogOutCubit(),
      ),
    ],
    child: BlocProvider(
      create: (context) => GetCartItemsCubit(),
      child: const RakliSalonsApp(),
    ),
  ));
  Bloc.observer = SimpleBLocObserver();
}

class RakliSalonsApp extends StatelessWidget {
  const RakliSalonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
