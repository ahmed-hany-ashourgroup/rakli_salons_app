import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
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
              CustomTextField(
                hint: "Enter new password",
                controller: newPasswordController,
                hintColor: Colors.black,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: "Confirm password",
                controller: confirmPasswordController,
                hintColor: Colors.black,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: Text(
                        "Done",
                        style:
                            AppStyles.bold16.copyWith(color: kSecondaryColor),
                      ),
                      onPressed: () {
                        if (newPasswordController.text ==
                            confirmPasswordController.text) {
                          // Handle password reset logic
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match!"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
