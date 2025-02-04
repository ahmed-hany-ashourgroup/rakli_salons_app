import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_edit_product_cubit/add_edit_prodcut_cubit.dart';

class AddEditProductView extends StatefulWidget {
  final ProductModel? product;
  final bool isEditMode;

  const AddEditProductView({
    super.key,
    this.product,
    required this.isEditMode,
  });

  @override
  _AddEditProductViewState createState() => _AddEditProductViewState();
}

class _AddEditProductViewState extends State<AddEditProductView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _sizeController;
  late TextEditingController _collectionIdController;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _titleController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price?.toString() ?? '');
    _sizeController =
        TextEditingController(text: widget.product?.size?.toString() ?? '');
    _collectionIdController = TextEditingController(
        text: widget.product?.collectionId?.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _collectionIdController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditProductCubit(),
      child: BlocConsumer<AddEditProductCubit, AddEditProductState>(
        listener: (context, state) {
          if (state is AddEditProductSuccess) {
            ToastService.showCustomToast(
              message:
                  'Product ${widget.isEditMode ? 'updated' : 'added'} successfully!',
              type: ToastType.success,
            );
            Navigator.pop(context, true);
          } else if (state is AddEditProductFailed) {
            ToastService.showCustomToast(
              message: state.errMessage,
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
                      if (state is AddEditProductLoading)
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
                  if (state is AddEditProductLoading)
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
          _buildImagePicker(),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _titleController,
            label: 'Product Title',
            hint: 'Enter product title',
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
            controller: _sizeController,
            label: 'Size',
            hint: 'Enter product size',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.straighten,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _collectionIdController,
            label: 'Collection ID',
            hint: 'Enter collection ID (optional)',
            keyboardType: TextInputType.number,
            prefixIcon: Icons.category,
            isRequired: false,
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Image',
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: _pickedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                : widget.product?.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.product!.image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      ),
          ),
        ),
      ],
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

  Widget _buildActionButtons(AddEditProductState state, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: Text(
              'Reset',
              style: AppStyles.regular16.copyWith(color: Colors.white),
            ),
            onPressed: state is AddEditProductLoading ? () {} : _resetForm,
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
            onPressed: state is AddEditProductLoading
                ? () {}
                : () {
                    _saveProduct(context: context);
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
    setState(() {
      _pickedImage = null;
    });
  }

  void _saveProduct({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      final price = num.parse(_priceController.text);
      final size = num.parse(_sizeController.text);
      final collectionId = int.tryParse(_collectionIdController.text);

      // Create form data
      final formData = FormData.fromMap({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'price': price.toString(),
        'size': size.toString(),
        'collection_id': collectionId ?? '',
        'product_type': 'product',
        'stock_status': 'available',
        if (widget.isEditMode && widget.product != null) '_method': "PUT",
      });

      if (widget.isEditMode && widget.product != null) {
        // For update, only add image if a new one is picked
        if (_pickedImage != null) {
          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(_pickedImage!.path,
                filename: 'product.jpg'),
          ));
        }

        context.read<AddEditProductCubit>().updateProduct(
              id: widget.product!.id!,
              data: formData,
            );
      } else {
        if (_pickedImage == null) {
          ToastService.showCustomToast(
            message: 'Please select an image',
            type: ToastType.error,
          );
          return;
        }

        // For new product, add the image file
        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(_pickedImage!.path,
              filename: 'product.jpg'),
        ));

        context.read<AddEditProductCubit>().addProduct(data: formData);
      }
    }
  }
}
