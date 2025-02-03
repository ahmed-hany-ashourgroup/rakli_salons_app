import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/add_to_cart_item_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int productQuantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Back Button
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.product.image!),
                        fit: BoxFit.cover),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image!,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 16,
                  left: 16,
                  child: SizedBox(
                    width: SizeConfig.screenwidth,
                    child: CustomAppBar(
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Product Title and Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.title!,
                    style: AppStyles.bold24.copyWith(color: Colors.black),
                  ),
                  Text(
                    '\$${widget.product.price ?? 0}',
                    style: AppStyles.bold24.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppStyles.bold20.copyWith(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description!,
                    style: AppStyles.light16.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 16),

            // Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: 4.9, // Example rating
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Color(0xffE8BD81),
                    ),
                    itemCount: 5,
                    itemSize: 24.0,
                  ),
                  const SizedBox(width: 8),
                  // Text(
                  //   widget.product.rating?.toStringAsFixed(1) ?? 'N/A',
                  //   style: AppStyles.light16.copyWith(color: Colors.black),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Divider(),

            // Quantity Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Quantity',
                    style: AppStyles.bold20.copyWith(color: Colors.black),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (productQuantity > 1) {
                            setState(() {
                              productQuantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove, color: Colors.black),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          productQuantity.toString(),
                          style: AppStyles.bold20.copyWith(color: Colors.black),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            productQuantity++;
                          });
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: BlocConsumer<AddToCartCubit, AddToCartState>(
                listener: (context, state) {
                  if (state is AddToCartSuccess) {
                    ToastService.showCustomToast(
                        message: 'Product added to cart successfully');
                  } else if (state is AddToCartFailed) {
                    ToastService.showCustomToast(message: state.errMessage);
                  }
                },
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          minwidth: 400,
                          borderRadius: 10,
                          title: state is AddToCartLoading
                              ? const CircularProgressIndicator(
                                  color: kSecondaryColor,
                                )
                              : Text(
                                  'Add to Cart',
                                  style: AppStyles.medium20.copyWith(
                                    color: kSecondaryColor,
                                  ),
                                ),
                          onPressed: state is AddToCartLoading
                              ? () {}
                              : () {
                                  // Prepare the request model
                                  AddToCartRequestModel requestModel =
                                      AddToCartRequestModel(
                                    id: widget.product.id,
                                    quantity: productQuantity,
                                    size: widget.product.size,
                                    price:
                                        double.tryParse(widget.product.price!),
                                  );

                                  // Call the cubit to add to cart
                                  context
                                      .read<AddToCartCubit>()
                                      .addToCart(requestModel);
                                },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
