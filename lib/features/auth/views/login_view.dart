import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/auth/manager/login_cubit/login_cubit.dart';

import '../../../core/utils/app_styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final formKey = GlobalKey<FormState>();
AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
final emailController = TextEditingController();
final passwordController = TextEditingController();

class _LoginViewState extends State<LoginView> {
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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset(
                      Assets.assetsImagesLogopng,
                    ),
                  ),
                  SizedBox(height: 100),
                  CustomTextField(
                    hintColor: kbackGroundColor.withValues(alpha: 0.5),
                    borderColor: kbackGroundColor,
                    hint: "Email Or Phone Number",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Simple email regex
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hint: "Password",
                    hintColor: kbackGroundColor.withValues(alpha: 0.5),
                    borderColor: kbackGroundColor,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        GoRouter.of(context)
                            .push(AppRouter.kForgotPasswordView);
                      },
                      child:
                          Text("Forgot Password?", style: AppStyles.regular16)),
                  SizedBox(height: 54),
                  CustomButton(
                      color: kPrimaryColor,
                      title: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            GoRouter.of(context).go(AppRouter.kHomeView);
                            Logger.info("UserModel: ${state.user.token}");
                          }
                          if (state is LoginFailed) {
                            ToastService.showCustomToast(
                                message: state.errMessage);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return const CircularProgressIndicator(
                              color: Colors.white,
                            );
                          } else {
                            return Text(
                              "Login",
                              style: AppStyles.bold16
                                  .copyWith(color: Colors.white),
                            );
                          }
                        },
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          GoRouter.of(context).go(AppRouter.kHomeView);

                          // await BlocProvider.of<LoginCubit>(context).login(
                          //     emailController.text, passwordController.text);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      }),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).go(AppRouter.kSignUpView);
                    },
                    child: Text(
                      "Don`t have an account? Sign up",
                      style:
                          AppStyles.regular16.copyWith(color: kbackGroundColor),
                    ),
                  ),
                  SizedBox(
                    height: 56,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
