import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';

class MyProductsView extends StatelessWidget {
  final List<ProductModel> products = [
    ProductModel(
      name: 'Product Name 4.9',
      description: 'description description description',
      price: 150,
      isCollection: false,
    ),
    ProductModel(
      name: 'pascal 4.9',
      description: 'Makeup Artist',
      price: 150,
      isCollection: true,
    ),
    // Add more products as needed
  ];

  MyProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: Column(
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
      child: ListTile(
        title: Text(product.name ?? 'No Name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.description ?? 'No Description'),
            const SizedBox(height: 4),
            Text('\$${product.price?.toStringAsFixed(2) ?? '0.00'}'),
          ],
        ),
        trailing: Text(
          product.isCollection ? 'Collection' : 'Product',
          style: TextStyle(
            color: product.isCollection ? Colors.blue : Colors.green,
          ),
        ),
      ),
    );
  }
}
