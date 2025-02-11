import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/cart_item_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/check_out_cubit/check_out_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_cart_items_cubit/get_cart_items_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  String selectedPaymentMethod = 'cash';

  @override
  void initState() {
    super.initState();
    context.read<GetCartItemsCubit>().getCartItems();
  }

  Widget _buildShimmerLoading() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: List.generate(3, (index) => _buildShimmerItem()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 24,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) {
            if (state is AddToCartSuccess || state is AddToCartFailed) {
              context.read<GetCartItemsCubit>().getCartItems();
            }
          },
        ),
      ],
      child: BlocBuilder<GetCartItemsCubit, GetCartItemsState>(
        builder: (context, state) {
          if (state is GetCartItemsLoading) {
            return _buildShimmerLoading();
          }

          if (state is GetCartItemsSuccess) {
            final cartItems = state.cartResponce.data?.productItems ?? [];
            final totalPrice = state.cartResponce.data?.totalPrice ?? 0;

            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  _buildHeader(context),
                  if (cartItems.isEmpty)
                    _buildEmptyCart()
                  else
                    Flexible(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              separatorBuilder: (_, __) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  color: Colors.grey.shade200,
                                  thickness: 1,
                                ),
                              ),
                              itemBuilder: (context, index) => CartItemTile(
                                product: cartItems[index],
                              ),
                            ),
                            _buildCheckoutSection(totalPrice, cartItems.length),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Center(
              child: Text(
                S.of(context).noItemsInCart,
                style: AppStyles.medium14.copyWith(color: Colors.black54),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            S.of(context).shoppingCart,
            style: AppStyles.bold20.copyWith(color: kPrimaryColor),
          ),
          const Spacer(),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 64,
              color: kPrimaryColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            S.of(context).yourCartIsEmpty,
            style: AppStyles.bold16.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).addItemsToGetStarted,
            style: AppStyles.regular14.copyWith(color: Colors.black38),
          ),
          const SizedBox(height: 32),
          CustomButton(
            hpadding: 24,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shopping_bag_outlined, color: kSecondaryColor),
                const SizedBox(width: 8),
                FittedBox(
                  child: Text(
                    S.of(context).startShopping,
                    style: AppStyles.medium14.copyWith(color: kSecondaryColor),
                  ),
                ),
              ],
            ),
            onPressed: () => Navigator.pop(context),
            borderRadius: 16,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(double totalPrice, int itemCount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).totalAmount,
                      style: AppStyles.medium14.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: AppStyles.bold24.copyWith(color: kPrimaryColor),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$itemCount ${itemCount == 1 ? S.of(context).item : S.of(context).items}',
                    style: AppStyles.medium14.copyWith(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).proceedToCheckout,
                    style: AppStyles.bold16.copyWith(color: kSecondaryColor),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: kSecondaryColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
              onPressed: () => _showPaymentMethodDialog(context),
              borderRadius: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.payment,
                color: kPrimaryColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).paymentMethod,
              style: AppStyles.bold20.copyWith(color: Colors.black),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPaymentOption('cash', Icons.money),
            const SizedBox(height: 12),
            _buildPaymentOption('credit', Icons.credit_card),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: AppStyles.medium14.copyWith(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  title: Text(
                    'Confirm',
                    style: AppStyles.medium14.copyWith(color: kSecondaryColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _handleCheckout();
                  },
                  borderRadius: 12,
                  minheight: 44,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, IconData icon) {
    final isSelected = selectedPaymentMethod == method;
    return InkWell(
      onTap: () => setState(() => selectedPaymentMethod = method),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? kPrimaryColor : Colors.grey.shade200,
            width: 2,
          ),
          color: isSelected ? kPrimaryColor.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? kPrimaryColor.withOpacity(0.1)
                    : Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? kPrimaryColor : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              method.toUpperCase(),
              style: AppStyles.medium14.copyWith(
                color: isSelected ? kPrimaryColor : Colors.black54,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: kPrimaryColor,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleCheckout() {
    context.read<CheckOutCubit>().placeOrder(
          paymentMethod: selectedPaymentMethod,
        );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItemModel product;

  const CartItemTile({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? '',
                            style: AppStyles.medium14.copyWith(
                              color: Colors.black87,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${product.price ?? ''}',
                            style: AppStyles.bold20.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _handleRemoveItem(context),
                      icon: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildQuantityControls(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          "http://89.116.110.219/storage/${product.image}",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey.shade400,
                  size: 32,
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).noImage,
                  style: AppStyles.regular10.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            context,
            Icons.remove,
            () => _handleDecreaseQuantity(context),
            product.quantity! > 1,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              product.quantity.toString().padLeft(2, '0'),
              style: AppStyles.bold16.copyWith(color: Colors.black),
            ),
          ),
          _buildQuantityButton(
            context,
            Icons.add,
            () => _handleIncreaseQuantity(context),
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
    bool isEnabled,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEnabled
                ? kPrimaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: isEnabled ? kPrimaryColor : Colors.grey.shade400,
          ),
        ),
      ),
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
    if (product.quantity! > 1) {
      context.read<AddToCartCubit>().decrementQuantity(
            productId: product.id!.toInt(),
            isCollection: product.isCollection ?? false,
            currentQuantity: product.quantity!,
            size: product.size,
          );
    }
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
