import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/logger.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_edit_product_cubit/add_edit_prodcut_cubit.dart';

enum ProductType { product, collection }

class PriceSizeEntry {
  final TextEditingController sizeController;
  final TextEditingController priceController;

  PriceSizeEntry()
      : sizeController = TextEditingController(),
        priceController = TextEditingController();

  Map<String, dynamic> toJson() => {
        'size': int.tryParse(sizeController.text) ?? "0",
        'price': int.tryParse(priceController.text) ?? 0,
      };
  void dispose() {
    sizeController.dispose();
    priceController.dispose();
  }
}

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
  final List<PriceSizeEntry> _priceSizeEntries = [];

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  File? _pickedImage;
  ProductType _selectedProductType = ProductType.product;
  bool _isAvailable = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _selectedProductType = widget.product?.isCollection ?? false
        ? ProductType.collection
        : ProductType.product;
    _addPriceSizeEntry();
  }

  void _initializeControllers() {
    _titleController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price?.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    for (var entry in _priceSizeEntries) {
      entry.dispose();
    }
    super.dispose();
  }

  void _addPriceSizeEntry() {
    setState(() {
      _priceSizeEntries.add(PriceSizeEntry());
    });
  }

  void _removePriceSizeEntry(int index) {
    setState(() {
      _priceSizeEntries[index].dispose();
      _priceSizeEntries.removeAt(index);
    });
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

  Widget _buildPriceSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Price & Size Combinations',
              style: AppStyles.bold16.copyWith(color: kPrimaryColor),
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: kPrimaryColor),
              onPressed: _addPriceSizeEntry,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _priceSizeEntries.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceSizeEntries[index].sizeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Size',
                          hintText: 'Enter size',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _priceSizeEntries[index].priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: 'Enter price',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_priceSizeEntries.length > 1)
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red[400]),
                        onPressed: () => _removePriceSizeEntry(index),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
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
          // _buildTextField(
          //   controller: _priceController,
          //   label: 'Price',
          //   hint: 'Enter product price',
          //   keyboardType: TextInputType.number,
          //   prefixIcon: Icons.attach_money,
          // ),
          const SizedBox(height: 20),
          _buildProductTypeDropdown(),
          const SizedBox(height: 20),
          _buildStockStatusToggle(),
          const SizedBox(height: 32),
          _buildPriceSizeSection(),
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

  Widget _buildProductTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Type',
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<ProductType>(
            value: _selectedProductType,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.category, color: kPrimaryColor, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            items: ProductType.values.map((ProductType type) {
              return DropdownMenuItem<ProductType>(
                value: type,
                child: Text(
                  type.toString().split('.').last,
                  style: AppStyles.regular16,
                ),
              );
            }).toList(),
            onChanged: (ProductType? value) {
              setState(() {
                _selectedProductType = value!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStockStatusToggle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stock Status',
          style: AppStyles.regular14.copyWith(color: Colors.grey[700]),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.inventory, color: kPrimaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                'Available',
                style: AppStyles.regular16,
              ),
              const Spacer(),
              Switch.adaptive(
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
                activeColor: kPrimaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                _isAvailable ? 'Available' : 'Unavailable',
                style: AppStyles.regular14.copyWith(
                  color: _isAvailable ? kPrimaryColor : Colors.grey,
                ),
              ),
            ],
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
      _selectedProductType = ProductType.product;
      _isAvailable = true;
    });
  }

  void _saveProduct({required BuildContext context}) async {
    if (_formKey.currentState!.validate()) {
      final detailsJson =
          jsonEncode(_priceSizeEntries.map((entry) => entry.toJson()).toList());

      if (widget.isEditMode && widget.product != null) {
        context.read<AddEditProductCubit>().updateProduct(
              id: widget.product!.id!,
              title: _titleController.text,
              description: _descriptionController.text,
              details: detailsJson, // Send the price-size array
              image: _pickedImage?.path ?? widget.product!.image!,
              productType: _selectedProductType == ProductType.product
                  ? 'product'
                  : 'collection',
              stockStatus: _isAvailable ? 'available' : 'unavailable',
            );
      } else {
        Logger.info(detailsJson.toString());
        context.read<AddEditProductCubit>().addProduct(
              title: _titleController.text,
              description: _descriptionController.text,
              details: detailsJson, // Send the price-size array
              image: _pickedImage!.path,
              productType: _selectedProductType == ProductType.product
                  ? 'product'
                  : 'collection',
              stockStatus: _isAvailable ? 'available' : 'unavailable',
            );
      }
    }
  }
}
