import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rakli_salons_app/core/errors/simple_bloc_observer.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/service_locator.dart';
import 'package:rakli_salons_app/features/auth/manager/log_out_cubit/log_out_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/check_out_cubit/check_out_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/filter_cubit/filter_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_cart_items_cubit/get_cart_items_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/search_cubit/search_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      emit(const Locale('ar'));
    } else {
      emit(const Locale('en'));
    }
  }
}

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
      BlocProvider(create: (context) => SalonsUserCubit()),
      BlocProvider(create: (context) => LanguageCubit()),
    ],
    child: BlocProvider(
      create: (context) => GetCartItemsCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Rakli Salons',
            locale: locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: AppRouter.router,
          );
        },
      ),
    ),
  ));
  Bloc.observer = SimpleBLocObserver();
}
