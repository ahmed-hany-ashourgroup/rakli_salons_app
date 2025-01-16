import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/auth/data/models/user_model.dart';
import 'package:rakli_salons_app/features/auth/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get form values
      String name = _nameController.text.trim();
      String phone = _phoneController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      // Create user model (mock data)

      SalonsUserCubit.user = UserModel(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
      // GoRouter.of(context).go(AppRouter.kHomeView);
      await BlocProvider.of<SignUpCubit>(context)
          .signUp(name: name, phone: phone, email: email, password: password);
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
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
                        controller: _nameController,
                        borderColor: kbackGroundColor,
                        hintColor: kbackGroundColor.withValues(alpha: 0.5),
                        hint: "Full Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _phoneController,
                        borderColor: kbackGroundColor,
                        hintColor: kbackGroundColor.withValues(alpha: 0.5),
                        hint: "Phone Number",
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _emailController,
                        borderColor: kbackGroundColor,
                        hintColor: kbackGroundColor.withValues(alpha: 0.5),
                        hint: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _passwordController,
                        borderColor: kbackGroundColor,
                        hintColor: kbackGroundColor.withValues(alpha: 0.5),
                        hint: "Password",
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).go(AppRouter.kLoginView);
                        },
                        child: Text(
                          "Already have an account? Login",
                          textAlign: TextAlign.center,
                          style:
                              AppStyles.regular16.copyWith(color: kTextColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                CustomButton(
                  title: BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        // Navigate to the next screen
                        GoRouter.of(context)
                            .go(AppRouter.kConfirmationCodeView);

                        // Optionally show a success toast
                        ToastService.showCustomToast(
                          message: "Signed up successfully!",
                          type: ToastType.success,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SignUpFailed) {
                        Logger.error(state.errMessage);
                        ToastService.showCustomToast(
                          message: state.errMessage,
                          type: ToastType.error,
                        );
                      }
                      if (state is SignUpLaoding) {
                        return const CircularProgressIndicator(
                          color: Colors.white,
                        );
                      }
                      return Text(
                        "Sign Up",
                        style: AppStyles.bold16.copyWith(color: Colors.white),
                      );
                    },
                  ),
                  onPressed: _submitForm,
                  color: kPrimaryColor,
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
