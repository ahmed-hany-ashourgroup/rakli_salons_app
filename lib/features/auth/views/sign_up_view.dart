import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/auth/manager/Business_Registration_Cubit/Business_Registration_Cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/Business_Registration_Cubit/Business_Registration_state.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';

class BusinessSignUpView extends StatefulWidget {
  const BusinessSignUpView({super.key});

  @override
  State<BusinessSignUpView> createState() => _BusinessSignUpViewState();
}

class _BusinessSignUpViewState extends State<BusinessSignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isSalon = true;

  // Controllers
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Image files for Salon
  File? _coverImage;
  File? _profilePhoto;
  File? _tradeLicenseImage;
  File? _taxRegistrationImage;

  // Image files for Freelancer
  File? _idCardImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        switch (type) {
          case 'cover':
            _coverImage = File(image.path);
            break;
          case 'photo':
            _profilePhoto = File(image.path);
            break;
          case 'license':
            _tradeLicenseImage = File(image.path);
            break;
          case 'tax':
            _taxRegistrationImage = File(image.path);
            break;
          case 'idcard':
            _idCardImage = File(image.path);
            break;
        }
      });
    }
  }

  Widget _buildImageUploadField(
      String title, File? imageFile, Function() onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.regular24.copyWith(
            color: kbackGroundColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: Image.file(imageFile, fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate,
                          size: 40, color: kbackGroundColor),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload',
                        style: AppStyles.regular24.copyWith(
                          color: kbackGroundColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUploadSection() {
    if (_isSalon) {
      return Column(
        children: [
          _buildImageUploadField(
            'Cover Image',
            _coverImage,
            () => _pickImage('cover'),
          ),
          _buildImageUploadField(
            'Profile Photo',
            _profilePhoto,
            () => _pickImage('photo'),
          ),
          _buildImageUploadField(
            'Trade License',
            _tradeLicenseImage,
            () => _pickImage('license'),
          ),
          _buildImageUploadField(
            'Tax Registration',
            _taxRegistrationImage,
            () => _pickImage('tax'),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildImageUploadField(
            'Profile Photo',
            _profilePhoto,
            () => _pickImage('photo'),
          ),
          _buildImageUploadField(
            'ID Card',
            _idCardImage,
            () => _pickImage('idcard'),
          ),
        ],
      );
    }
  }

  Future<void> _handleRegistration() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Validate required images
      if (_profilePhoto == null) {
        _showErrorSnackBar('Profile photo is required');
        return;
      }

      if (_isSalon) {
        if (_tradeLicenseImage == null || _taxRegistrationImage == null) {
          _showErrorSnackBar('Trade license and tax registration are required');
          return;
        }
      } else {
        if (_idCardImage == null) {
          _showErrorSnackBar('ID card is required');
          return;
        }
      }

      // Get the cubit instance
      final cubit = context.read<BusinessRegistrationCubit>();

      try {
        final result = await cubit.register(
          businessName: _businessNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          role: _isSalon ? 'salon' : 'freelancer',
          latitude: 31.12345, // You might want to get actual location
          longitude: 33.12345,
          method: 'email',
          photo: _profilePhoto!,
          cover: _coverImage,
          tradeLicense: _tradeLicenseImage,
          taxRegistration: _taxRegistrationImage,
          idCard: _idCardImage,
        );
        SalonsUserCubit.user.email = _emailController.text;
        result.fold(
          (failure) => _showErrorSnackBar(failure.message),
          (user) => GoRouter.of(context).go(AppRouter.kConfirmationCodeView),
        );
      } catch (e) {
        _showErrorSnackBar('An error occurred during registration');
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ToastService.showCustomToast(message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BusinessRegistrationCubit, BusinessRegistrationState>(
        listener: (context, state) {
          if (state is BusinessRegistrationLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            // Hide loading indicator if it's showing
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            if (state is BusinessRegistrationSuccess) {
              GoRouter.of(context).push(AppRouter.kConfirmationCodeView);
            } else if (state is BusinessRegistrationFailed) {
              _showErrorSnackBar(state.errMessage);
            }
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFE4D6), Color(0xFFFFF5EC)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(
                        Assets.assetsImagesLogopng,
                      ),
                    ),
                    Text(
                      'Business Registration',
                      style: AppStyles.bold24.copyWith(color: kbackGroundColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Basic Information Section
                    CustomTextField(
                      controller: _businessNameController,
                      hint: 'Business Name',
                      borderColor: kbackGroundColor,
                      hintColor: kbackGroundColor.withOpacity(0.5),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter business name'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _emailController,
                      hint: 'Email',
                      borderColor: kbackGroundColor,
                      hintColor: kbackGroundColor.withOpacity(0.5),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Please enter email';
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value!)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      borderColor: kbackGroundColor,
                      hintColor: kbackGroundColor.withOpacity(0.5),
                      obscureText: true,
                      validator: (value) => (value?.length ?? 0) < 8
                          ? 'Password must be at least 8 characters'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _phoneController,
                      hint: 'Phone',
                      borderColor: kbackGroundColor,
                      hintColor: kbackGroundColor.withOpacity(0.5),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter phone number'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _addressController,
                      hint: 'Address',
                      borderColor: kbackGroundColor,
                      hintColor: kbackGroundColor.withOpacity(0.5),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter address'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Role Selection
                    Text(
                      'Business Type',
                      style: AppStyles.regular24.copyWith(
                        color: kbackGroundColor,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text(
                              'Salon',
                              style: AppStyles.regular24.copyWith(
                                color: kbackGroundColor,
                                fontSize: 16,
                              ),
                            ),
                            value: true,
                            groupValue: _isSalon,
                            activeColor: kbackGroundColor,
                            onChanged: (value) {
                              setState(() {
                                _isSalon = value!;
                                if (value) {
                                  _idCardImage = null;
                                }
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: Text(
                              'Freelancer',
                              style: AppStyles.regular24.copyWith(
                                color: kbackGroundColor,
                                fontSize: 16,
                              ),
                            ),
                            value: false,
                            groupValue: _isSalon,
                            activeColor: kbackGroundColor,
                            onChanged: (value) {
                              setState(() {
                                _isSalon = value!;
                                if (!value) {
                                  _coverImage = null;
                                  _tradeLicenseImage = null;
                                  _taxRegistrationImage = null;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Dynamic Image Upload Section
                    _buildUploadSection(),

                    const SizedBox(height: 24),

                    // Submit Button
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kPrimaryColor,
                      ),
                      child: CustomButton(
                        onPressed: _handleRegistration,
                        title: Text(
                          'Submit',
                          style: AppStyles.bold16.copyWith(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go(AppRouter.kLoginView);
                      },
                      child: Text(
                        'Have an account? Login',
                        style: AppStyles.regular16
                            .copyWith(color: kbackGroundColor),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
