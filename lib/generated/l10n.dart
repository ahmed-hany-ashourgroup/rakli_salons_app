// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rakli Salons`
  String get appName {
    return Intl.message(
      'Rakli Salons',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Verify Password`
  String get verifyPassword {
    return Intl.message(
      'Verify Password',
      name: 'verifyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Code`
  String get resetCode {
    return Intl.message(
      'Reset Code',
      name: 'resetCode',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message(
      'Privacy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Appointments`
  String get appointments {
    return Intl.message(
      'Appointments',
      name: 'appointments',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `My Products`
  String get myProducts {
    return Intl.message(
      'My Products',
      name: 'myProducts',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out of your account?\nYou will need to log in again to access your account.`
  String get signOutConfirmation {
    return Intl.message(
      'Are you sure you want to sign out of your account?\nYou will need to log in again to access your account.',
      name: 'signOutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Debug`
  String get debug {
    return Intl.message(
      'Debug',
      name: 'debug',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get passwordResetSuccess {
    return Intl.message(
      'Password reset successful',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Password reset failed`
  String get passwordResetFailed {
    return Intl.message(
      'Password reset failed',
      name: 'passwordResetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email for a confirmation link to reset your password.`
  String get passwordResetConfirmation {
    return Intl.message(
      'Please check your email for a confirmation link to reset your password.',
      name: 'passwordResetConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirmation Code`
  String get enterConfirmationCode {
    return Intl.message(
      'Enter Confirmation Code',
      name: 'enterConfirmationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enterYourEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Email sent`
  String get emailSent {
    return Intl.message(
      'Email sent',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `Email not sent`
  String get emailNotSent {
    return Intl.message(
      'Email not sent',
      name: 'emailNotSent',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email for a confirmation link to reset your password.`
  String get emailSentConfirmation {
    return Intl.message(
      'Please check your email for a confirmation link to reset your password.',
      name: 'emailSentConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email for a confirmation link to reset your password.`
  String get emailNotSentConfirmation {
    return Intl.message(
      'Please check your email for a confirmation link to reset your password.',
      name: 'emailNotSentConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `please Enter Confirmation Code`
  String get pleaseEnterYourConfirmationCode {
    return Intl.message(
      'please Enter Confirmation Code',
      name: 'pleaseEnterYourConfirmationCode',
      desc: '',
      args: [],
    );
  }

  /// `Signed Up Successfully`
  String get signedUpSuccessfully {
    return Intl.message(
      'Signed Up Successfully',
      name: 'signedUpSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Business Registration`
  String get businessRegistration {
    return Intl.message(
      'Business Registration',
      name: 'businessRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Business Name`
  String get businessName {
    return Intl.message(
      'Business Name',
      name: 'businessName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter business name`
  String get pleaseEnterBusinessName {
    return Intl.message(
      'Please enter business name',
      name: 'pleaseEnterBusinessName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterPhone {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter address`
  String get pleaseEnterAddress {
    return Intl.message(
      'Please enter address',
      name: 'pleaseEnterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Business Type`
  String get businessType {
    return Intl.message(
      'Business Type',
      name: 'businessType',
      desc: '',
      args: [],
    );
  }

  /// `Salon`
  String get salon {
    return Intl.message(
      'Salon',
      name: 'salon',
      desc: '',
      args: [],
    );
  }

  /// `Freelancer`
  String get freelancer {
    return Intl.message(
      'Freelancer',
      name: 'freelancer',
      desc: '',
      args: [],
    );
  }

  /// `Cover Image`
  String get coverImage {
    return Intl.message(
      'Cover Image',
      name: 'coverImage',
      desc: '',
      args: [],
    );
  }

  /// `Profile Photo`
  String get profilePhoto {
    return Intl.message(
      'Profile Photo',
      name: 'profilePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Trade License`
  String get tradeLicense {
    return Intl.message(
      'Trade License',
      name: 'tradeLicense',
      desc: '',
      args: [],
    );
  }

  /// `Tax Registration`
  String get taxRegistration {
    return Intl.message(
      'Tax Registration',
      name: 'taxRegistration',
      desc: '',
      args: [],
    );
  }

  /// `ID Card`
  String get idCard {
    return Intl.message(
      'ID Card',
      name: 'idCard',
      desc: '',
      args: [],
    );
  }

  /// `Tap to upload`
  String get tapToUpload {
    return Intl.message(
      'Tap to upload',
      name: 'tapToUpload',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? Login`
  String get haveAnAccount {
    return Intl.message(
      'Have an account? Login',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign up`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? Sign up',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email Or Phone Number`
  String get emailOrPhone {
    return Intl.message(
      'Email Or Phone Number',
      name: 'emailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Edit Account`
  String get editAccount {
    return Intl.message(
      'Edit Account',
      name: 'editAccount',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Account details updated!`
  String get accountDetailsUpdated {
    return Intl.message(
      'Account details updated!',
      name: 'accountDetailsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter your email address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code sent to your email`
  String get verificationCodeSent {
    return Intl.message(
      'Please enter verification code sent to your email',
      name: 'verificationCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `Verify Code`
  String get verifyCode {
    return Intl.message(
      'Verify Code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Enter your new password',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get pleaseFillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'pleaseFillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Account Deleted Successfully`
  String get accountDeletedSuccessfully {
    return Intl.message(
      'Account Deleted Successfully',
      name: 'accountDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Profile photo is required`
  String get profilePhotoRequired {
    return Intl.message(
      'Profile photo is required',
      name: 'profilePhotoRequired',
      desc: '',
      args: [],
    );
  }

  /// `Trade license and tax registration are required`
  String get tradeLicenseAndTaxRegistrationRequired {
    return Intl.message(
      'Trade license and tax registration are required',
      name: 'tradeLicenseAndTaxRegistrationRequired',
      desc: '',
      args: [],
    );
  }

  /// `ID card is required`
  String get idCardRequired {
    return Intl.message(
      'ID card is required',
      name: 'idCardRequired',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during registration`
  String get anErrorOccurredDuringRegistration {
    return Intl.message(
      'An error occurred during registration',
      name: 'anErrorOccurredDuringRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Plans`
  String get plans {
    return Intl.message(
      'Plans',
      name: 'plans',
      desc: '',
      args: [],
    );
  }

  /// `Basic Plan`
  String get basicPlan {
    return Intl.message(
      'Basic Plan',
      name: 'basicPlan',
      desc: '',
      args: [],
    );
  }

  /// `${price}/Monthly`
  String monthlyPrice(Object price) {
    return Intl.message(
      '\$$price/Monthly',
      name: 'monthlyPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Ideal for small salons starting out with basic management needs.`
  String get basicPlanDescription {
    return Intl.message(
      'Ideal for small salons starting out with basic management needs.',
      name: 'basicPlanDescription',
      desc: '',
      args: [],
    );
  }

  /// `Manage up to 50 appointments per month`
  String get manageAppointments {
    return Intl.message(
      'Manage up to 50 appointments per month',
      name: 'manageAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Add and manage up to 10 services`
  String get manageServices {
    return Intl.message(
      'Add and manage up to 10 services',
      name: 'manageServices',
      desc: '',
      args: [],
    );
  }

  /// `Basic analytics and reporting`
  String get basicAnalytics {
    return Intl.message(
      'Basic analytics and reporting',
      name: 'basicAnalytics',
      desc: '',
      args: [],
    );
  }

  /// `Email support`
  String get emailSupport {
    return Intl.message(
      'Email support',
      name: 'emailSupport',
      desc: '',
      args: [],
    );
  }

  /// `No services available`
  String get noServicesAvailable {
    return Intl.message(
      'No services available',
      name: 'noServicesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Add Service`
  String get addService {
    return Intl.message(
      'Add Service',
      name: 'addService',
      desc: '',
      args: [],
    );
  }

  /// `Delete Service`
  String get deleteService {
    return Intl.message(
      'Delete Service',
      name: 'deleteService',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this service? This action is permanent and cannot be undone. All associated data will be permanently removed.`
  String get deleteServiceConfirmation {
    return Intl.message(
      'Are you sure you want to delete this service? This action is permanent and cannot be undone. All associated data will be permanently removed.',
      name: 'deleteServiceConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Service deleted successfully`
  String get serviceDeletedSuccessfully {
    return Intl.message(
      'Service deleted successfully',
      name: 'serviceDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `No address provided`
  String get noAddressProvided {
    return Intl.message(
      'No address provided',
      name: 'noAddressProvided',
      desc: '',
      args: [],
    );
  }

  /// `Location not set`
  String get locationNotSet {
    return Intl.message(
      'Location not set',
      name: 'locationNotSet',
      desc: '',
      args: [],
    );
  }

  /// `No phone number`
  String get noPhoneNumber {
    return Intl.message(
      'No phone number',
      name: 'noPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Request Password Change`
  String get requestPasswordChange {
    return Intl.message(
      'Request Password Change',
      name: 'requestPasswordChange',
      desc: '',
      args: [],
    );
  }

  /// `We'll send a verification code to your email`
  String get verificationCodeMessage {
    return Intl.message(
      'We\'ll send a verification code to your email',
      name: 'verificationCodeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code sent to your email`
  String get enterVerificationCode {
    return Intl.message(
      'Enter the verification code sent to your email',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code`
  String get pleaseEnterVerificationCode {
    return Intl.message(
      'Please enter the verification code',
      name: 'pleaseEnterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter name`
  String get pleaseEnterName {
    return Intl.message(
      'Please enter name',
      name: 'pleaseEnterName',
      desc: '',
      args: [],
    );
  }

  /// `No products found.`
  String get noProductsFound {
    return Intl.message(
      'No products found.',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProductTitle {
    return Intl.message(
      'Delete Product',
      name: 'deleteProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product? This action is permanent and cannot be undone. All associated data will be permanently removed.`
  String get deleteProductMessage {
    return Intl.message(
      'Are you sure you want to delete this product? This action is permanent and cannot be undone. All associated data will be permanently removed.',
      name: 'deleteProductMessage',
      desc: '',
      args: [],
    );
  }

  /// `Product deleted successfully`
  String get productDeletedSuccessfully {
    return Intl.message(
      'Product deleted successfully',
      name: 'productDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No Description`
  String get noDescription {
    return Intl.message(
      'No Description',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Item`
  String get unknownItem {
    return Intl.message(
      'Unknown Item',
      name: 'unknownItem',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart successfully`
  String get productAddedToCart {
    return Intl.message(
      'Product added to cart successfully',
      name: 'productAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Product Quantity`
  String get productQuantity {
    return Intl.message(
      'Product Quantity',
      name: 'productQuantity',
      desc: '',
      args: [],
    );
  }

  /// `No Name`
  String get noName {
    return Intl.message(
      'No Name',
      name: 'noName',
      desc: '',
      args: [],
    );
  }

  /// `No orders found`
  String get noOrdersFound {
    return Intl.message(
      'No orders found',
      name: 'noOrdersFound',
      desc: '',
      args: [],
    );
  }

  /// `Order #{0}`
  String get orderNumber {
    return Intl.message(
      'Order #{0}',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Payment: {0}`
  String get paymentType {
    return Intl.message(
      'Payment: {0}',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Date: {0}`
  String get orderDate {
    return Intl.message(
      'Date: {0}',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get notAvailable {
    return Intl.message(
      'N/A',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `State: `
  String get stateLabel {
    return Intl.message(
      'State: ',
      name: 'stateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get paymentLabel {
    return Intl.message(
      'Payment',
      name: 'paymentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dateLabel {
    return Intl.message(
      'Date',
      name: 'dateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `Total Bookings`
  String get totalBookings {
    return Intl.message(
      'Total Bookings',
      name: 'totalBookings',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Active Services`
  String get activeServices {
    return Intl.message(
      'Active Services',
      name: 'activeServices',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Appointments`
  String get upcomingAppointments {
    return Intl.message(
      'Upcoming Appointments',
      name: 'upcomingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Today's Appointments`
  String get todaysAppointments {
    return Intl.message(
      'Today\'s Appointments',
      name: 'todaysAppointments',
      desc: '',
      args: [],
    );
  }

  /// `This Week's Appointments`
  String get thisWeeksAppointments {
    return Intl.message(
      'This Week\'s Appointments',
      name: 'thisWeeksAppointments',
      desc: '',
      args: [],
    );
  }

  /// `This Month's Appointments`
  String get thisMonthsAppointments {
    return Intl.message(
      'This Month\'s Appointments',
      name: 'thisMonthsAppointments',
      desc: '',
      args: [],
    );
  }

  /// `This Year's Appointments`
  String get thisYearsAppointments {
    return Intl.message(
      'This Year\'s Appointments',
      name: 'thisYearsAppointments',
      desc: '',
      args: [],
    );
  }

  /// `No appointments found`
  String get noAppointmentsFound {
    return Intl.message(
      'No appointments found',
      name: 'noAppointmentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Customer`
  String get unknownCustomer {
    return Intl.message(
      'Unknown Customer',
      name: 'unknownCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Booking ID: #{id}`
  String bookingId(Object id) {
    return Intl.message(
      'Booking ID: #$id',
      name: 'bookingId',
      desc: '',
      args: [id],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Appointment status updated successfully`
  String get appointmentStatusUpdated {
    return Intl.message(
      'Appointment status updated successfully',
      name: 'appointmentStatusUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get applyFilters {
    return Intl.message(
      'Apply Filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }

  /// `Skin Care`
  String get skinCare {
    return Intl.message(
      'Skin Care',
      name: 'skinCare',
      desc: '',
      args: [],
    );
  }

  /// `Hair Services`
  String get hairServices {
    return Intl.message(
      'Hair Services',
      name: 'hairServices',
      desc: '',
      args: [],
    );
  }

  /// `Makeup Services`
  String get makeupServices {
    return Intl.message(
      'Makeup Services',
      name: 'makeupServices',
      desc: '',
      args: [],
    );
  }

  /// `Body Treatments`
  String get bodyTreatments {
    return Intl.message(
      'Body Treatments',
      name: 'bodyTreatments',
      desc: '',
      args: [],
    );
  }

  /// `Nail Services`
  String get nailServices {
    return Intl.message(
      'Nail Services',
      name: 'nailServices',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message(
      'Add Product',
      name: 'addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service`
  String get editService {
    return Intl.message(
      'Edit Service',
      name: 'editService',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basicInformation {
    return Intl.message(
      'Basic Information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Product Title`
  String get productTitle {
    return Intl.message(
      'Product Title',
      name: 'productTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter product title`
  String get enterProductTitle {
    return Intl.message(
      'Enter product title',
      name: 'enterProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Service Title`
  String get serviceTitle {
    return Intl.message(
      'Service Title',
      name: 'serviceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter service title`
  String get enterServiceTitle {
    return Intl.message(
      'Enter service title',
      name: 'enterServiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter description`
  String get enterDescription {
    return Intl.message(
      'Enter description',
      name: 'enterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Pricing & Details`
  String get pricingAndDetails {
    return Intl.message(
      'Pricing & Details',
      name: 'pricingAndDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter price`
  String get enterPrice {
    return Intl.message(
      'Enter price',
      name: 'enterPrice',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Enter product size`
  String get enterSize {
    return Intl.message(
      'Enter product size',
      name: 'enterSize',
      desc: '',
      args: [],
    );
  }

  /// `Collection ID`
  String get collectionId {
    return Intl.message(
      'Collection ID',
      name: 'collectionId',
      desc: '',
      args: [],
    );
  }

  /// `Enter collection ID (optional)`
  String get enterCollectionId {
    return Intl.message(
      'Enter collection ID (optional)',
      name: 'enterCollectionId',
      desc: '',
      args: [],
    );
  }

  /// `Product Image`
  String get productImage {
    return Intl.message(
      'Product Image',
      name: 'productImage',
      desc: '',
      args: [],
    );
  }

  /// `Promotions (Optional)`
  String get promotions {
    return Intl.message(
      'Promotions (Optional)',
      name: 'promotions',
      desc: '',
      args: [],
    );
  }

  /// `Enter promotion amount`
  String get enterPromotionAmount {
    return Intl.message(
      'Enter promotion amount',
      name: 'enterPromotionAmount',
      desc: '',
      args: [],
    );
  }

  /// `Service Status`
  String get serviceStatus {
    return Intl.message(
      'Service Status',
      name: 'serviceStatus',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive {
    return Intl.message(
      'Inactive',
      name: 'inactive',
      desc: '',
      args: [],
    );
  }

  /// `Product updated successfully!`
  String get productUpdated {
    return Intl.message(
      'Product updated successfully!',
      name: 'productUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully!`
  String get productAdded {
    return Intl.message(
      'Product added successfully!',
      name: 'productAdded',
      desc: '',
      args: [],
    );
  }

  /// `Service updated successfully!`
  String get serviceUpdated {
    return Intl.message(
      'Service updated successfully!',
      name: 'serviceUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Service added successfully!`
  String get serviceAdded {
    return Intl.message(
      'Service added successfully!',
      name: 'serviceAdded',
      desc: '',
      args: [],
    );
  }

  /// `Please select an image`
  String get pleaseSelectImage {
    return Intl.message(
      'Please select an image',
      name: 'pleaseSelectImage',
      desc: '',
      args: [],
    );
  }

  /// `{field} is required`
  String isRequired(Object field) {
    return Intl.message(
      '$field is required',
      name: 'isRequired',
      desc: '',
      args: [field],
    );
  }

  /// `Please enter a valid number`
  String get pleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'pleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shoppingCart {
    return Intl.message(
      'Shopping Cart',
      name: 'shoppingCart',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add items to get started`
  String get addItemsToGetStarted {
    return Intl.message(
      'Add items to get started',
      name: 'addItemsToGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Start Shopping`
  String get startShopping {
    return Intl.message(
      'Start Shopping',
      name: 'startShopping',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get item {
    return Intl.message(
      'item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message(
      'items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed to Checkout',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `CASH`
  String get cash {
    return Intl.message(
      'CASH',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `CREDIT`
  String get credit {
    return Intl.message(
      'CREDIT',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `No items in cart`
  String get noItemsInCart {
    return Intl.message(
      'No items in cart',
      name: 'noItemsInCart',
      desc: '',
      args: [],
    );
  }

  /// `No Image`
  String get noImage {
    return Intl.message(
      'No Image',
      name: 'noImage',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get priceRange {
    return Intl.message(
      'Price Range',
      name: 'priceRange',
      desc: '',
      args: [],
    );
  }

  /// `Price: Low to High`
  String get sortByPriceLowToHigh {
    return Intl.message(
      'Price: Low to High',
      name: 'sortByPriceLowToHigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to Low`
  String get sortByPriceHighToLow {
    return Intl.message(
      'Price: High to Low',
      name: 'sortByPriceHighToLow',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get sortByMostPopular {
    return Intl.message(
      'Most Popular',
      name: 'sortByMostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Best Rating`
  String get sortByBestRating {
    return Intl.message(
      'Best Rating',
      name: 'sortByBestRating',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get sortByNewest {
    return Intl.message(
      'Newest',
      name: 'sortByNewest',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Image not available`
  String get imageNotAvailable {
    return Intl.message(
      'Image not available',
      name: 'imageNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Product`
  String get unknownProduct {
    return Intl.message(
      'Unknown Product',
      name: 'unknownProduct',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart`
  String get addedToCart {
    return Intl.message(
      'Added to cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get removedFromFavorites {
    return Intl.message(
      'Removed from favorites',
      name: 'removedFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites`
  String get addedToFavorites {
    return Intl.message(
      'Added to favorites',
      name: 'addedToFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Search products`
  String get searchProducts {
    return Intl.message(
      'Search products',
      name: 'searchProducts',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get noProductsFoundMessage {
    return Intl.message(
      'No products found',
      name: 'noProductsFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `${start} - ${end}`
  String priceRangeLabel(Object start, Object end) {
    return Intl.message(
      '\$$start - \$$end',
      name: 'priceRangeLabel',
      desc: '',
      args: [start, end],
    );
  }

  /// `$`
  String get currencySymbol {
    return Intl.message(
      '\$',
      name: 'currencySymbol',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `No favorites yet`
  String get noFavoritesYet {
    return Intl.message(
      'No favorites yet',
      name: 'noFavoritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Error: {message}`
  String errorOccurredWithMessage(Object message) {
    return Intl.message(
      'Error: $message',
      name: 'errorOccurredWithMessage',
      desc: '',
      args: [message],
    );
  }

  /// `Jan`
  String get january {
    return Intl.message(
      'Jan',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `Feb`
  String get february {
    return Intl.message(
      'Feb',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `Mar`
  String get march {
    return Intl.message(
      'Mar',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `Apr`
  String get april {
    return Intl.message(
      'Apr',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get may {
    return Intl.message(
      'May',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `Jun`
  String get june {
    return Intl.message(
      'Jun',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `Jul`
  String get july {
    return Intl.message(
      'Jul',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `Aug`
  String get august {
    return Intl.message(
      'Aug',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `Sep`
  String get september {
    return Intl.message(
      'Sep',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `Oct`
  String get october {
    return Intl.message(
      'Oct',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `Nov`
  String get november {
    return Intl.message(
      'Nov',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `Dec`
  String get december {
    return Intl.message(
      'Dec',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get itemStateActive {
    return Intl.message(
      'Active',
      name: 'itemStateActive',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get itemStateInactive {
    return Intl.message(
      'Inactive',
      name: 'itemStateInactive',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get itemStatePending {
    return Intl.message(
      'Pending',
      name: 'itemStatePending',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get itemStateAvailable {
    return Intl.message(
      'Available',
      name: 'itemStateAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable`
  String get itemStateUnavailable {
    return Intl.message(
      'Unavailable',
      name: 'itemStateUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Sold Out`
  String get itemStateSoldOut {
    return Intl.message(
      'Sold Out',
      name: 'itemStateSoldOut',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get revenue {
    return Intl.message(
      'Revenue',
      name: 'revenue',
      desc: '',
      args: [],
    );
  }

  /// `Gender Distribution`
  String get genderDistribution {
    return Intl.message(
      'Gender Distribution',
      name: 'genderDistribution',
      desc: '',
      args: [],
    );
  }

  /// `Male\n{percentage}%`
  String malePercentage(Object percentage) {
    return Intl.message(
      'Male\n$percentage%',
      name: 'malePercentage',
      desc: '',
      args: [percentage],
    );
  }

  /// `Female\n{percentage}%`
  String femalePercentage(Object percentage) {
    return Intl.message(
      'Female\n$percentage%',
      name: 'femalePercentage',
      desc: '',
      args: [percentage],
    );
  }

  /// `Sort by Price`
  String get sortByPrice {
    return Intl.message(
      'Sort by Price',
      name: 'sortByPrice',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Rating`
  String get sortByRating {
    return Intl.message(
      'Sort by Rating',
      name: 'sortByRating',
      desc: '',
      args: [],
    );
  }

  /// `Sort by Distance`
  String get sortByDistance {
    return Intl.message(
      'Sort by Distance',
      name: 'sortByDistance',
      desc: '',
      args: [],
    );
  }

  /// `Transform Your Look, and Feel Confident Inside and Out!`
  String get welcomeMessage {
    return Intl.message(
      'Transform Your Look, and Feel Confident Inside and Out!',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
