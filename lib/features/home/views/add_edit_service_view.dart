import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/features/home/data/models/service_model.dart';

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
    _selectedState = widget.service?.state ?? ServiceState.active;
    _selectedGender = widget.service?.gender ?? Gender.male;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        _buildFormSection(),
                        const SizedBox(height: 32),
                        _buildActionButtons(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          },
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

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: Text(
              'Reset',
              style: AppStyles.regular16.copyWith(color: Colors.white),
            ),
            onPressed: _resetForm,
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
            onPressed: _saveService,
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

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      final service = ServiceModel(
        title: _titleController.text,
        description: _descriptionController.text,
        price: num.tryParse(_priceController.text),
        state: _selectedState,
        gender: _selectedGender,
      );

      Logger.info('Service saved: $service');
      Navigator.pop(context);
    }
  }
}
