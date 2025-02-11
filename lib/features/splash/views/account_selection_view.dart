import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class AccountSelectionView extends StatelessWidget {
  const AccountSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE4D6), // Darker beige
              Color(0xFFFFF5EC), // Light beige
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: SizedBox(
                height: 400,
                width: 400,
                child: Image.asset(
                  Assets.assetsImagesLogopng,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text(
                S.of(context).welcomeMessage,
                style: AppStyles.bold32.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kSignUpView);
                      },
                      title: FittedBox(
                        child: Text(
                          S.of(context).register,
                          style: AppStyles.medium20
                              .copyWith(color: kSecondaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: CustomButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kLoginView);
                      },
                      title: FittedBox(
                        child: Text(
                          S.of(context).login,
                          style: AppStyles.medium20
                              .copyWith(color: kSecondaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
