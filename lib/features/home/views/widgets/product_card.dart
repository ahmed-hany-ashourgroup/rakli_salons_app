import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
          width: 150,
          height: 280,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              // Content Overlay
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Favorite Icon
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kBorderColor,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: kTextColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Product Details
                    Text(
                      product.title!,
                      style: AppStyles.bold14.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '\$${product.price}',
                          style: AppStyles.bold14.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        // Text(
                        //   product.rating.toString(),
                        //   style: AppStyles.regular13.copyWith(
                        //     color: Colors.white.withOpacity(0.7),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
