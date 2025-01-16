import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            CustomAppBar(
              backButtonColor: kPrimaryColor,
              title: Text(
                "Edit Account",
                style: AppStyles.bold24.copyWith(color: Colors.black),
              ),
              icon: const SizedBox.shrink(),
            ),
            const Spacer(),
            CustomTextField(
              hint: "Email",
              hintColor: Colors.black,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: "Name",
              hintColor: Colors.black,
              controller: nameController,
              keyboardType: TextInputType.text,
              suffixIcon: const Icon(
                Icons.person_outline,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: "Phone",
              hintColor: Colors.black,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              suffixIcon: const Icon(
                Icons.phone_outlined,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: Text(
                      "Confirm",
                      style: AppStyles.bold16.copyWith(color: kSecondaryColor),
                    ),
                    onPressed: () {
                      // Handle update logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account details updated!"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Spacer(flex: 6),
          ],
        ),
      ),
    );
  }
}
