import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/cart_item_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/check_out_cubit/check_out_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_cart_items_cubit/get_cart_items_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String selectedPaymentMethod = 'cash';

  @override
  void initState() {
    super.initState();
    context.read<GetCartItemsCubit>().getCartItems();
  }

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Payment Method',
            style: AppStyles.bold20.copyWith(color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('cash'),
                leading: Radio(
                  value: 'cash',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Credit Card'),
                leading: Radio(
                  value: 'credit',
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: AppStyles.medium14.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _handleCheckout(); // Trigger the checkout process
              },
              child: Text(
                'Confirm',
                style: AppStyles.medium14.copyWith(color: kPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleCheckout() {
    context.read<CheckOutCubit>().placeOrder(
          paymentMethod: selectedPaymentMethod,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddToCartCubit, AddToCartState>(
            listener: (context, state) {
              if (state is AddToCartFailed) {
                ToastService.showCustomToast(message: state.errMessage);
              }
              if (state is AddToCartSuccess) {
                context.read<GetCartItemsCubit>().getCartItems();
              }
            },
          ),
          BlocListener<CheckOutCubit, CheckOutState>(
            listener: (context, state) {
              if (state is CheckOutLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is CheckOutSuccess) {
                Navigator.pop(context); // Dismiss loading dialog
                ToastService.showCustomToast(
                    message: "Order Placed Successfully");
                context.read<GetCartItemsCubit>().getCartItems();
              }
              if (state is CheckOutFailed) {
                Navigator.pop(context); // Dismiss loading dialog
                ToastService.showCustomToast(message: state.errMessage);
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
            builder: (context, state) {
              if (state is GetCartItemsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetCartItemsSuccess) {
                final cartItems = state.cartResponce.data?.productItems ?? [];
                final totalPrice = state.cartResponce.data?.totalPrice ?? 0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),
                    CustomAppBar(
                      backButtonColor: kPrimaryColor,
                      icon: const SizedBox(height: 50),
                      title: Text(
                        "Shopping Bag",
                        style: AppStyles.bold24.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (cartItems.isNotEmpty) ...[
                      Text(
                        "Your Products",
                        style: AppStyles.bold20.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final product = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CartItemWidget(product: product),
                            );
                          },
                        ),
                      ),
                      _buildPromoCodeSection(),
                      SizedBox(height: SizeConfig.screenwidth! * 0.28),
                      _buildTotalSection(cartItems.length, totalPrice),
                      SizedBox(height: SizeConfig.screenwidth! * 0.1),
                      _buildCheckoutButton(context, cartItems.isNotEmpty),
                      SizedBox(height: SizeConfig.screenhieght! * 0.1),
                    ] else ...[
                      const Spacer(),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_basket,
                              color: Colors.black,
                              size: 100,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Your cart is empty",
                              style: AppStyles.bold20
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Add some items to get started",
                              style: AppStyles.regular16
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ],
                );
              } else if (state is GetCartItemsFailed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 56),
                      CustomAppBar(
                        backButtonColor: kPrimaryColor,
                        icon: const SizedBox(height: 50),
                        title: Text(
                          "Shopping Bag",
                          style: AppStyles.bold24.copyWith(color: Colors.black),
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 16),
                      Text(
                        "Your cart is empty",
                        style: AppStyles.bold20.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Add some items to get started",
                        style: AppStyles.regular16.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      const Spacer(),
                    ],
                  ),
                );
              }
              return const Center(child: Text("No cart items found."));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: CustomButton(
                  title: Text(
                    "Apply",
                    style: AppStyles.medium12.copyWith(color: kSecondaryColor),
                  ),
                  onPressed: () {},
                  vpadding: 0,
                  minheight: 40,
                ),
              ),
              hintText: "Promo Code",
              hintStyle: AppStyles.light16.copyWith(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSection(int itemCount, double totalPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total ($itemCount items)",
          style: AppStyles.bold20.copyWith(color: Colors.black),
        ),
        Text(
          "\$${totalPrice.toStringAsFixed(2)}",
          style: AppStyles.bold20.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, bool hasItems) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            borderRadius: 8,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Checkout with ${selectedPaymentMethod.toUpperCase()}',
                  style: AppStyles.medium20.copyWith(color: kSecondaryColor),
                ),
                const SizedBox(width: 8),
                Icon(
                  selectedPaymentMethod == 'cash'
                      ? Icons.money
                      : Icons.credit_card,
                  color: kSecondaryColor,
                ),
              ],
            ),
            onPressed: hasItems
                ? () {
                    _showPaymentMethodDialog(); // Show payment method dialog
                  }
                : () {}, // Disable button if cart is empty
          ),
        ),
      ],
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItemModel product;

  const CartItemWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProductImage(),
        const SizedBox(width: 16),
        _buildProductInfo(),
        _buildQuantityControls(context),
      ],
    );
  }

  Widget _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        "http://89.116.110.219/storage/${product.image}",
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      ),
    );
  }

  Widget _buildProductInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title ?? '',
            style: AppStyles.bold16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${product.price?.toStringAsFixed(2) ?? ''}',
            style: AppStyles.light16.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => _handleRemoveItem(context),
          icon: const Icon(Icons.close, color: kbackGroundColor, size: 16),
        ),
        Row(
          children: [
            IconButton(
              onPressed: product.quantity! > 1
                  ? () => _handleDecreaseQuantity(context)
                  : null, // Disable button if quantity is 1
              icon: Icon(
                Icons.remove_circle_outline,
                color: product.quantity! > 1 ? Colors.black : Colors.grey,
                size: 24,
              ),
            ),
            Text(
              product.quantity.toString().padLeft(2, '0'),
              style: AppStyles.bold16.copyWith(color: Colors.black),
            ),
            IconButton(
              onPressed: () => _handleIncreaseQuantity(context),
              icon: const Icon(Icons.add_circle_rounded,
                  color: kPrimaryColor, size: 24),
            ),
          ],
        ),
      ],
    );
  }

  void _handleRemoveItem(BuildContext context) {
    context.read<AddToCartCubit>().removeFromCart(
          productId: product.id.toString(),
          isCollection: product.isCollection ?? false,
          size: product.size,
        );
  }

  void _handleDecreaseQuantity(BuildContext context) {
    context.read<AddToCartCubit>().decrementQuantity(
          productId: product.id!.toInt(),
          isCollection: product.isCollection ?? false,
          currentQuantity: product.quantity!,
          size: product.size,
        );
  }

  void _handleIncreaseQuantity(BuildContext context) {
    context.read<AddToCartCubit>().incrementQuantity(
          productId: product.id.toString(),
          isCollection: product.isCollection ?? false,
          currentQuantity: product.quantity!,
          size: product.size,
        );
  }
}
