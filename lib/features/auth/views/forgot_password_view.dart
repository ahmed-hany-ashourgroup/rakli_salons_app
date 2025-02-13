import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/auth/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  int step = 1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          if (step == 1) {
            Fluttertoast.showToast(
              msg: S.of(context).emailSentConfirmation,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            setState(() => step = 2);
          } else if (step == 2) {
            Fluttertoast.showToast(
              msg: S.of(context).verifyCode,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            setState(() => step = 3);
          } else if (step == 3) {
            Fluttertoast.showToast(
              msg: S.of(context).passwordResetSuccess,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.pop(context);
          }
        } else if (state is ResetPasswordFailed) {
          Fluttertoast.showToast(
            msg: state.errMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Spacer(),
              _buildCurrentStep(),
              const Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state is ResetPasswordLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        switch (step) {
          case 1:
            return _buildEmailStep();
          case 2:
            return _buildVerificationStep();
          case 3:
            return _buildNewPasswordStep();
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).enterEmailAddress,
          style: AppStyles.regular16.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hint: S.of(context).email,
          hintColor: kbackGroundColor.withValues(alpha: 0.5),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          borderColor: kbackGroundColor,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                title: Text(
                  S.of(context).sendCode,
                  style: AppStyles.bold16.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    context
                        .read<ResetPasswordCubit>()
                        .requestResetPassword(emailController.text);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).verificationCodeSent,
          style: AppStyles.regular16.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hint: S.of(context).resetCode,
          hintColor: kbackGroundColor.withValues(alpha: 0.5),
          controller: codeController,
          keyboardType: TextInputType.number,
          borderColor: kbackGroundColor,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                title: Text(
                  S.of(context).verifyCode,
                  style: AppStyles.bold16.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (codeController.text.isNotEmpty) {
                    context.read<ResetPasswordCubit>().verifyPasswordRest(
                          email: emailController.text,
                          resetCode: codeController.text,
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNewPasswordStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).pleaseEnterNewPassword,
          style: AppStyles.regular16.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hint: S.of(context).newPassword,
          controller: newPasswordController,
          hintColor: kbackGroundColor.withValues(alpha: 0.5),
          obscureText: true,
          borderColor: kbackGroundColor,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hint: S.of(context).confirmPassword,
          controller: confirmPasswordController,
          hintColor: kbackGroundColor.withValues(alpha: 0.5),
          obscureText: true,
          borderColor: kbackGroundColor,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                title: Text(
                  S.of(context).resetPassword,
                  style: AppStyles.bold16.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  if (newPasswordController.text.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: S.of(context).pleaseFillAllFields,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    Fluttertoast.showToast(
                      msg: S.of(context).passwordsDoNotMatch,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  context.read<ResetPasswordCubit>().resetPassword(
                        email: emailController.text,
                        newPassword: newPasswordController.text,
                        resetCode: codeController.text,
                      );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
