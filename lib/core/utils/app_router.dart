import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/features/auth/manager/confirmation_code_cubit/confirmation_code_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:rakli_salons_app/features/auth/views/confirmation_code_view.dart';
import 'package:rakli_salons_app/features/auth/views/forgot_password_view.dart';
import 'package:rakli_salons_app/features/auth/views/login_view.dart';
import 'package:rakli_salons_app/features/auth/views/sign_up_view.dart';
import 'package:rakli_salons_app/features/home/views/filter_view.dart';
import 'package:rakli_salons_app/features/home/views/home_view.dart';
import 'package:rakli_salons_app/features/splash/views/account_selection_view.dart';
import 'package:rakli_salons_app/features/splash/views/splash_view.dart';

class AppRouter {
  static const String kSplashView = '/';
  static const String kAccountSelectionView = '/account-selection';
  static const String kLoginView = '/login';
  static const String kSignUpView = '/sign-up';
  static const String kSetLocationView = '/set-location';
  static const String kSerachView = '/search';
  static const String kStylistProfileView = '/stylist-profile';
  static const String kFilterView = '/filter';
  static const String kForgotPasswordView = '/forgot-password';
  static const String kConfirmationCodeView = '/confirmation-code';

  static const String kHomeView = '/home';

  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: kSplashView,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: kAccountSelectionView,
      builder: (context, state) => const AccountSelectionView(),
    ),
    GoRoute(
      path: kForgotPasswordView,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ResetPasswordCubit()),
          BlocProvider(create: (context) => ConfirmationCodeCubit()),
        ],
        child: const ForgotPasswordView(),
      ),
    ),
    GoRoute(
      path: kConfirmationCodeView,
      builder: (context, state) => BlocProvider(
        create: (context) => ConfirmationCodeCubit(),
        child: const ConfirmationCodeView(),
      ),
    ),
    GoRoute(
      path: kLoginView,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginView(),
      ),
    ),
    GoRoute(
      path: kSignUpView,
      builder: (context, state) => BlocProvider(
        create: (context) => SignUpCubit(),
        child: const SignUpView(),
      ),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: kFilterView,
      builder: (context, state) => const FilterView(),
    ),
  ]);
}

void navigateWithAnimation(
  BuildContext context, {
  required String routeName,
  required Widget page,
}) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
