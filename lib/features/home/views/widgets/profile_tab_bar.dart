import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_textfield.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/features/auth/manager/reset_password_cubit/reset_password_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/update_profile_cubit/update_profile_cubit.dart';
import 'package:rakli_salons_app/features/auth/manager/user_cubit/user_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(text: S.of(context).profile),
        Tab(text: S.of(context).account),
      ],
      labelColor: kPrimaryColor,
      labelStyle: AppStyles.bold14,
      unselectedLabelColor: Colors.black,
      indicatorColor: kPrimaryColor,
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const SalonInformation(),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}

class SalonInformation extends StatelessWidget {
  const SalonInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SalonsUserCubit.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(user.name ?? S.of(context).businessName,
                style: AppStyles.bold24),
            const SizedBox(width: 8),
            const Icon(Icons.verified, color: kPrimaryColor),
          ],
        ),
        const SizedBox(height: 16),
        Text(S.of(context).address, style: AppStyles.medium20),
        const SizedBox(height: 8),
        Text(user.address ?? S.of(context).noAddressProvided,
            style: AppStyles.regular16),
        const SizedBox(height: 16),
        const LocationInfo(),
      ],
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SalonsUserCubit.user;

    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: kPrimaryColor),
            const SizedBox(width: 8),
            Text(user.address ?? S.of(context).locationNotSet,
                style: AppStyles.regular16),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.phone, color: kPrimaryColor),
            const SizedBox(width: 8),
            Text(user.phone ?? S.of(context).noPhoneNumber,
                style: AppStyles.regular16),
          ],
        ),
      ],
    );
  }
}

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CustomProfileTile(
            iconPath: Assets.assetsImagesHeart,
            title: S.of(context).favorite,
            onTap: () => GoRouter.of(context).push(AppRouter.kFavoritesView),
          ),
          CustomProfileTile(
            iconPath: Assets.assetsImagesLock,
            title: S.of(context).changePassword,
            onTap: () => _showChangePasswordBottomSheet(context),
          ),
          CustomProfileTile(
            iconPath: Assets.assetsImagesOrder,
            title: S.of(context).orders,
            onTap: () {
              context.read<GetOrdersCubit>().getOrders();
              GoRouter.of(context).push(AppRouter.kOrdersView);
            },
          ),
          CustomProfileTile(
            iconPath: Assets.assetsImagesEdit,
            title: S.of(context).editProfile,
            onTap: () => _showEditProfileBottomSheet(context),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const ChangePasswordForm(),
          ),
        ),
      ),
    );
  }

  void _showEditProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const EditProfileForm(),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _codeController = TextEditingController();
  int step = 1;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
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
                msg: S.of(context).passwordChangedSuccessfully,
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
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    step == 1
                        ? S.of(context).requestPasswordChange
                        : step == 2
                            ? S.of(context).verifyCode
                            : S.of(context).changePassword,
                    style: AppStyles.bold20.copyWith(color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  if (step == 1)
                    Text(
                      S.of(context).verificationCodeMessage,
                      style: AppStyles.regular14.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  if (step == 2) ...[
                    Text(
                      S.of(context).enterVerificationCode,
                      style: AppStyles.regular14.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hint: S.of(context).verificationCode,
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.of(context).pleaseEnterVerificationCode;
                        }
                        return null;
                      },
                    ),
                  ],
                  if (step == 3) ...[
                    CustomTextField(
                      hint: S.of(context).newPassword,
                      controller: _newPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return S.of(context).pleaseEnterNewPassword;
                        }
                        if (value!.length < 8) {
                          return S.of(context).passwordMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hint: S.of(context).confirmPassword,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return S.of(context).passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Text(
                            S.of(context).cancel,
                            style: AppStyles.medium14
                                .copyWith(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state is ResetPasswordLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final cubit =
                                        context.read<ResetPasswordCubit>();
                                    if (step == 1) {
                                      cubit.requestResetPassword(
                                          SalonsUserCubit.user.email ?? '');
                                    } else if (step == 2) {
                                      cubit.verifyPasswordRest(
                                        email: SalonsUserCubit.user.email ?? '',
                                        resetCode: _codeController.text,
                                      );
                                    } else if (step == 3) {
                                      cubit.resetPassword(
                                        email: SalonsUserCubit.user.email ?? '',
                                        newPassword:
                                            _newPasswordController.text,
                                        resetCode: _codeController.text,
                                      );
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state is ResetPasswordLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  step == 1
                                      ? S.of(context).sendCode
                                      : step == 2
                                          ? S.of(context).verify
                                          : S.of(context).changePassword,
                                  style: AppStyles.medium14
                                      .copyWith(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = SalonsUserCubit.user;
    _emailController.text = user.email ?? '';
    _nameController.text = user.name ?? '';
    _phoneController.text = user.phone ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(),
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileSuccess) {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: S.of(context).profileUpdatedSuccessfully,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
          } else if (state is UpdateProfileFailed) {
            Fluttertoast.showToast(
              msg: state.errMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    S.of(context).editProfile,
                    style: AppStyles.bold20.copyWith(color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    hint: S.of(context).email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterYourEmail;
                      }
                      if (!value.contains('@')) {
                        return S.of(context).pleaseEnterValidEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: S.of(context).name,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hint: S.of(context).phone,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterPhone;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: Text(
                            S.of(context).cancel,
                            style: AppStyles.medium14
                                .copyWith(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state is UpdateProfileLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<UpdateProfileCubit>()
                                        .updateProfile(
                                          email: _emailController.text,
                                          name: _nameController.text,
                                          phone: _phoneController.text,
                                          buissniesId: SalonsUserCubit.user.id
                                              .toString(),
                                        );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: state is UpdateProfileLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Text(
                                  S.of(context).saveChanges,
                                  style: AppStyles.medium14
                                      .copyWith(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomProfileTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color iconColor;

  const CustomProfileTile({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor,
            ),
            child: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
