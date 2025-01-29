import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/features/auth/manager/Business_Registration_Cubit/Business_Registration_Cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/confirmation_code_cubit/confirmation_code_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:rakli_salons_app/features/auth/views/confirmation_code_view.dart';
import 'package:rakli_salons_app/features/auth/views/forgot_password_view.dart';
import 'package:rakli_salons_app/features/auth/views/login_view.dart';
import 'package:rakli_salons_app/features/auth/views/sign_up_view.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_new_service_cubit/add_service_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';
import 'package:rakli_salons_app/features/home/views/add_edit_service_view.dart';
import 'package:rakli_salons_app/features/home/views/add_product_view.dart';
import 'package:rakli_salons_app/features/home/views/cart_view.dart';
import 'package:rakli_salons_app/features/home/views/favorites_view.dart';
import 'package:rakli_salons_app/features/home/views/filter_view.dart';
import 'package:rakli_salons_app/features/home/views/home_view.dart';
import 'package:rakli_salons_app/features/home/views/my_products_view.dart';
import 'package:rakli_salons_app/features/home/views/notifications_view.dart';
import 'package:rakli_salons_app/features/home/views/orders_view.dart';
import 'package:rakli_salons_app/features/home/views/product_details_view.dart';
import 'package:rakli_salons_app/features/home/views/products_view.dart';
import 'package:rakli_salons_app/features/home/views/reports_view.dart';
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
  static const String kNotificationsView = '/notifications';
  static const String kAddEditServiceView = '/add-edit-service';
  static const String kHomeView = '/home';
  static const String kAddProductView = '/add-product';
  static const String kProductDetailsView = '/product-details';

  static const String kReportsView = '/reports';
  static const String kShopView = '/shop';
  static const String kCartView = '/cart';

  static const String kMyProductsView = '/my-products';
  static const String kFavoritesView = '/favorites';
  static const String kOrdersView = '/orders';

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
      path: kOrdersView,
      builder: (context, state) => const OrdersView(),
    ),
    GoRoute(
      path: kProductDetailsView,
      builder: (context, state) => ProductDetailsView(
        product: state.extra as ProductModel,
      ),
    ),
    GoRoute(
      path: kFavoritesView,
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      path: kReportsView,
      builder: (context, state) => const ReportsView(),
    ),
    GoRoute(
      path: kShopView,
      builder: (context, state) => const ProductsView(),
    ),
    GoRoute(
      path: kCartView,
      builder: (context, state) => const CartView(),
    ),
    GoRoute(
      path: kMyProductsView,
      builder: (context, state) => MyProductsView(),
    ),
    GoRoute(
        path: kAddProductView,
        builder: (context, state) {
          if (state.extra != null) {
            Map data = state.extra as Map;
            return AddProductView(
              product: data['product'] as ProductModel?,
              isEditMode: data['isEditMode'],
            );
          } else {
            return const HomeView();
          }
        }),
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
        create: (context) => BusinessRegistrationCubit(),
        child: const BusinessSignUpView(),
      ),
    ),
    GoRoute(
      path: kHomeView,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
        path: kAddEditServiceView,
        builder: (context, state) {
          if (state.extra != null) {
            Map data = state.extra as Map;
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AddServiceCubit(),
                ),
                BlocProvider(
                  create: (context) => GetServicesCubit(),
                ),
              ],
              child: AddEditServiceView(
                service: data['service'] as ServiceModel?,
                isEditMode: data['isEditMode'],
              ),
            );
          } else {
            return const HomeView();
          }
        }),
    GoRoute(
      path: kNotificationsView,
      builder: (context, state) => const NotificationsView(),
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
