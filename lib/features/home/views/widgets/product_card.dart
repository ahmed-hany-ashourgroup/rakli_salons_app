import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/toast_service.dart';
import 'package:rakli_salons_app/features/home/data/models/models/add_to_cart_item_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

import '../../manager/Products_wish_list_cubit/products_wish_list_cubit.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAddingToCart = false;
  bool _isProcessingWishlist = false;
  final double buttonSize = 32.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: kPrimaryColor,
      textColor: Colors.white,
    );
  }

  void _animateButton() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  void _handleAddToCart() async {
    if (_isAddingToCart) return;

    setState(() {
      _isAddingToCart = true;
    });

    _animateButton();

    final request = AddToCartRequestModel(
      id: widget.product.id!,
      isCollection: widget.product.isCollection,
      quantity: 1,
      price: widget.product.price,
      size: widget.product.size.toString(),
    );

    await context.read<AddToCartCubit>().addToCart(request);

    setState(() {
      _isAddingToCart = false;
    });

    if (!mounted) return;

    _showToast(S.of(context).addedToCart);
  }

  void _handleWishlistToggle() async {
    if (_isProcessingWishlist) return;

    setState(() {
      _isProcessingWishlist = true;
    });

    _animateButton();

    final cubit = context.read<ProductsWishListCubit>();
    final wasInWishlist = cubit.isProductInWishlist(widget.product.id!);
    final success = await cubit.toggleWishlistStatus(widget.product.id!);

    if (mounted) {
      setState(() {
        _isProcessingWishlist = false;
      });

      if (success) {
        final message = wasInWishlist
            ? S.of(context).removedFromFavorites
            : S.of(context).addedToFavorites;
        ToastService.showCustomToast(message: message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsWishListCubit, ProductsWishListState>(
      listener: (context, state) {
        // Force rebuild when wishlist state changes
        if (state is ProductsWishListLoaded) {
          setState(() {});
        }
      },
      builder: (context, state) {
        final isInWishlist = context
            .read<ProductsWishListCubit>()
            .isProductInWishlist(widget.product.id!);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Container
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.image ?? '',
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[100],
                        child: Center(
                          child: Text(
                            'Image not available',
                            style: AppStyles.regular13.copyWith(
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Product Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.product.name ?? S.of(context).unknownProduct,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium14,
                      ),
                      const Spacer(),
                      // Price and Actions Row
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final hasEnoughWidth = constraints.maxWidth >=
                              (buttonSize * 2 +
                                  70); // Space for price and 2 buttons

                          if (hasEnoughWidth) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Price
                                Text(
                                  '${S.of(context).currencySymbol}${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                                  style: AppStyles.bold16
                                      .copyWith(color: kPrimaryColor),
                                ),
                                // Action Buttons
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildCartButton(),
                                    const SizedBox(width: 6),
                                    _buildFavoriteButton(isInWishlist),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            // Stack layout for very narrow widths
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${S.of(context).currencySymbol}${widget.product.price?.toStringAsFixed(2) ?? '0.00'}',
                                  style: AppStyles.bold16
                                      .copyWith(color: kPrimaryColor),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildCartButton(),
                                    const SizedBox(width: 6),
                                    _buildFavoriteButton(isInWishlist),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartButton() {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: _isAddingToCart
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                )
              : const Icon(Icons.shopping_cart_outlined, size: 18),
          color: Colors.black87,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(Size(buttonSize, buttonSize)),
          onPressed: _isAddingToCart ? null : _handleAddToCart,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(bool isInWishlist) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.8).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: _isProcessingWishlist
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                  ),
                )
              : Icon(
                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                ),
          color: isInWishlist ? Colors.red : Colors.black87,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(Size(buttonSize, buttonSize)),
          onPressed: _isProcessingWishlist ? null : _handleWishlistToggle,
        ),
      ),
    );
  }
}
