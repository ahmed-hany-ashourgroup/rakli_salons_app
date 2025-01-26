import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

class AddProductView extends StatefulWidget {
  final ProductModel? product;
  final bool isEditMode;

  const AddProductView({
    super.key,
    this.product,
    required this.isEditMode,
  });

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late String _productType;
  late String _stockStatus;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price?.toString() ?? '');
    _discountController = TextEditingController();
    _productType =
        widget.product?.isCollection == true ? 'collection' : 'product';
    _stockStatus = 'Available'; // Default status
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
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
          widget.isEditMode ? 'Edit Product' : 'Add Product',
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
            controller: _nameController,
            label: 'Product Name',
            hint: 'Enter product name',
            prefixIcon: Icons.title,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Enter product description',
            maxLines: 6,
            prefixIcon: Icons.description,
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Pricing & Details'),
          const SizedBox(height: 24),
          _buildTextField(
            controller: _priceController,
            label: 'Price',
            hint: 'Enter product price',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.attach_money,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _discountController,
            label: 'Discount in percentage',
            hint: 'Enter discount percentage',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.discount,
          ),
          const SizedBox(height: 20),
          _buildDropdown(
            'Product Type',
            ['product', 'collection'],
            _productType,
            (value) {
              setState(() {
                _productType = value!;
              });
            },
            prefixIcon: Icons.category,
          ),
          const SizedBox(height: 20),
          _buildDropdown(
            'Stock Status',
            ['Available', 'Unavailable'],
            _stockStatus,
            (value) {
              setState(() {
                _stockStatus = value!;
              });
            },
            prefixIcon: Icons.inventory,
          ),
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

  Widget _buildDropdown(
    String label,
    List<String> items,
    String value,
    Function(String?) onChanged, {
    required IconData prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon, color: kPrimaryColor, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppStyles.regular16,
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              return null;
            },
          ),
        ),
      ],
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
                widget.isEditMode ? 'Save Changes' : 'Add Product',
                style: AppStyles.regular16.copyWith(color: Colors.white),
              ),
            ),
            onPressed: _saveProduct,
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

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final product = ProductModel(
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text),
        isCollection: _productType == 'collection',
      );

      // Save the product logic here
      Navigator.pop(context);
    }
  }
}
