import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/get_my_products_cubit.dart/get_my_products_cubit.dart';

class MyProductsView extends StatelessWidget {
  const MyProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: BlocProvider(
        create: (context) => GetMyProductsCubit()..getMyProducts(),
        child: BlocBuilder<GetMyProductsCubit, GetMyProductsState>(
          builder: (context, state) {
            if (state is GetMyProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetMyProductsSuccess) {
              final products = state.products;
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomSearchField(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductItem(product: product);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is GetMyProductsFailed) {
              return Center(child: Text(state.errMessage));
            } else {
              return const Center(child: Text('No products found.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kAddProductView, extra: {
            'isEditMode': false,
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final ProductModel product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.image ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Rating
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // const Icon(Icons.star, color: Colors.amber, size: 16),
                      // Text(
                      //   ' ${product.rating?.toStringAsFixed(1) ?? '0.0'}',
                      //   style: const TextStyle(fontSize: 14),
                      // ),
                      const SizedBox(width: 8),
                      GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppRouter.kAddProductView, extra: {
                              'isEditMode': true,
                              'product': product,
                            });
                          },
                          child: Icon(Icons.edit,
                              size: 18, color: Colors.grey[700])),
                      const SizedBox(width: 8),
                      const Icon(Icons.close, color: Colors.red, size: 18),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Price
                  Text(
                    '\$${product.price ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    product.description ?? 'No Description',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // State Indicator
                  Row(
                    children: [
                      const Text(
                        'State: ',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.circle, size: 10, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        'Available',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
