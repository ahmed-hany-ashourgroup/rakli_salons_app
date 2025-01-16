import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/auth/manager/confirmation_code_cubit/confirmation_code_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

import '../../../core/customs/custom_textfield.dart';

class ConfirmationCodeView extends StatefulWidget {
  const ConfirmationCodeView({super.key});

  @override
  State<ConfirmationCodeView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<ConfirmationCodeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // Controllers for form fields
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFE4D6), // Darker beige
              const Color(0xFFFFF5EC), // Light beige
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 53),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 56),
                CustomAppBar(
                  backButtonColor: kPrimaryColor,
                  icon: CircleAvatar(
                    backgroundColor: kSecondaryColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    Assets.assetsImagesLogopng,
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        controller: codeController,
                        borderColor: kbackGroundColor,
                        hintColor: kbackGroundColor.withValues(alpha: 0.5),
                        hint: "Enter Code",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Your Confirmation Code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: BlocConsumer<ConfirmationCodeCubit,
                            ConfirmationCodeState>(
                          listener: (context, state) {
                            if (state is ConfirmationCodeSuccess) {
                              SalonsUserCubit.user = state.user;
                              // Navigate to the next screen
                              GoRouter.of(context).go(AppRouter.kHomeView);

                              // Optionally show a success toast
                              ToastService.showCustomToast(
                                message: "Signed up successfully!",
                                type: ToastType.success,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is ConfirmationCodeFailed) {
                              // Optionally show a success toast
                              ToastService.showCustomToast(
                                message: state.errMessage,
                                type: ToastType.error,
                              );
                            }
                            if (state is ConfirmationCodeLoading) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            return Text(
                              "Sign Up",
                              style: AppStyles.bold16
                                  .copyWith(color: Colors.white),
                            );
                          },
                        ),
                        onPressed: () {
                          BlocProvider.of<ConfirmationCodeCubit>(context)
                              .confirmCodeSignUp(codeController.text);
                        },
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
