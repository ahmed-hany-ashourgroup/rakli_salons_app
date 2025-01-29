import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_new_service_cubit/add_service_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';

class AddEditServiceView extends StatefulWidget {
  final ServiceModel? service;
  final bool isEditMode;

  const AddEditServiceView({
    super.key,
    this.service,
    required this.isEditMode,
  });

  @override
  _AddEditServiceViewState createState() => _AddEditServiceViewState();
}

class _AddEditServiceViewState extends State<AddEditServiceView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _promotionsController;
  late ServiceState _selectedState;
  late Gender _selectedGender;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _titleController = TextEditingController(text: widget.service?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.service?.description ?? '');
    _priceController =
        TextEditingController(text: widget.service?.price?.toString() ?? '');
    _promotionsController = TextEditingController(
        text: widget.service?.promotions?.toString() ?? '');
    _selectedState = widget.service?.state ?? ServiceState.active;
    _selectedGender = widget.service?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _promotionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceCubit(),
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state) {
          if (state is AddServiceSuccess) {
            ToastService.showCustomToast(
              message: state.message,
              type: ToastType.success,
            );
            Navigator.pop(context, true);
          } else if (state is AddServiceFailure) {
            ToastService.showCustomToast(
              message: state.error,
              type: ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildAppBar(),
                      if (state is AddServiceLoading)
                        const LinearProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 32),
                                  _buildFormSection(),
                                  const SizedBox(height: 32),
                                  _buildActionButtons(state, context),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state is AddServiceLoading)
                    const Positioned.fill(
                      child: ColoredBox(
                        color: Colors.black26,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomAppBar(
        title: Text(
          widget.isEditMode ? 'Edit Service' : 'Add Service',
          style: AppStyles.bold20.copyWith(color: Colors.black),
        ),
        icon: TextButton(
          onPressed: _resetForm,
          child: Text(
            "Reset",
            style: AppStyles.regular16.copyWith(color: Colors.black),
          ),
        ),
        backButtonColor: kPrimaryColor,
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Basic Information'),
          const SizedBox(height: 24),
          _buildTextField(
            controller: _titleController,
            label: 'Service Title',
            hint: 'Enter service title',
            prefixIcon: Icons.title,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Enter service description',
            maxLines: 6,
            prefixIcon: Icons.description,
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Pricing & Details'),
          const SizedBox(height: 24),
          _buildTextField(
            controller: _priceController,
            label: 'Price',
            hint: 'Enter service price',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.attach_money,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _promotionsController,
            label: 'Promotions (Optional)',
            hint: 'Enter promotion amount',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.local_offer,
            isRequired: false,
          ),
          const SizedBox(height: 20),
          _buildGenderDropdown(),
          const SizedBox(height: 20),
          _buildStateToggle(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppStyles.bold16.copyWith(color: kPrimaryColor),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppStyles.regular14.copyWith(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: Icon(prefixIcon, color: kPrimaryColor, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppStyles.regular16,
          validator: isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  if (keyboardType == TextInputType.number &&
                      double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<Gender>(
            value: _selectedGender,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.people, color: kPrimaryColor, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            items: Gender.values.map((Gender gender) {
              return DropdownMenuItem<Gender>(
                value: gender,
                child: Text(
                  gender.toString().split('.').last,
                  style: AppStyles.regular16,
                ),
              );
            }).toList(),
            onChanged: (Gender? value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStateToggle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.toggle_on, color: kPrimaryColor, size: 20),
          const SizedBox(width: 12),
          Text(
            'Service Status',
            style: AppStyles.regular16,
          ),
          const Spacer(),
          Switch.adaptive(
            value: _selectedState == ServiceState.active,
            onChanged: (value) {
              setState(() {
                _selectedState =
                    value ? ServiceState.active : ServiceState.inactive;
              });
            },
            activeColor: kPrimaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            _selectedState == ServiceState.active ? 'Active' : 'Inactive',
            style: AppStyles.regular14.copyWith(
              color: _selectedState == ServiceState.active
                  ? kPrimaryColor
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(AddServiceState state, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: Text(
              'Reset',
              style: AppStyles.regular16.copyWith(color: Colors.white),
            ),
            onPressed: state is AddServiceLoading ? () {} : _resetForm,
            color: kBorderColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            title: FittedBox(
              child: Text(
                widget.isEditMode ? 'Save Changes' : 'Add Service',
                style: AppStyles.regular16.copyWith(color: Colors.white),
              ),
            ),
            onPressed: state is AddServiceLoading
                ? () {}
                : () {
                    _saveService(context: context);
                  },
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _initializeControllers();
  }

  void _saveService({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      final price = double.parse(_priceController.text);
      final promotions = _promotionsController.text.isNotEmpty
          ? double.parse(_promotionsController.text)
          : null;
      final gender = _selectedGender == Gender.male ? 'male' : 'female';

      if (widget.isEditMode && widget.service != null) {
        context.read<AddServiceCubit>().updateService(
              serviceId: widget.service!.id!,
              title: _titleController.text,
              description: _descriptionController.text,
              price: price,
              gender: gender,
              promotions: promotions,
            );
        await context.read<GetServicesCubit>().fetchServices();
      } else {
        context.read<AddServiceCubit>().addService(
              title: _titleController.text,
              description: _descriptionController.text,
              price: price,
              gender: gender,
              promotions: promotions,
            );
        await context.read<GetServicesCubit>().fetchServices();
      }
    }
  }
}
