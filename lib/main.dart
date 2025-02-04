import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/errors/simple_bloc_observer.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_cart_items_cubit/get_cart_items_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(BlocProvider(
    create: (context) => AddToCartCubit(),
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
