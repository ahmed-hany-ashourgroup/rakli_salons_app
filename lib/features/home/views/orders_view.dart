import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/order_model.dart';

import '../../../core/customs/custom_app_bar.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<OrderModel> orders = []; // Replace with your actual orders list>
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 56),
            CustomAppBar(
              backButtonColor: kPrimaryColor,
              title: Text(
                "Orders",
                style: AppStyles.bold24.copyWith(color: Colors.black),
              ),
              icon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                    });
                  },
                  child: Text(
                    "Appointment",
                    style: AppStyles.bold16.copyWith(
                      color: selectedTab == 0 ? kPrimaryColor : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 1;
                    });
                  },
                  child: Text(
                    "Product",
                    style: AppStyles.bold16.copyWith(
                      color: selectedTab == 1 ? kPrimaryColor : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
                child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.id}",
                        style: AppStyles.bold16.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      ...order.items!.map((item) => buildOrderItem(item)),
                      const SizedBox(height: 8),
                      Text(
                        "Total: \$${order.totalPrice?.toStringAsFixed(2)}",
                        style: AppStyles.bold16.copyWith(color: Colors.black),
                      ),
                      const Divider(),
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget buildOrderItem(OrderItemModel item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: "http://89.116.110.219/storage/${item.image}",
            errorWidget: (context, url, error) {
              return const Icon(Icons.error);
            },
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title ?? '',
                style: AppStyles.bold16.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                "Quantity: ${item.quantity}",
                style: AppStyles.regular13.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          "\$${item.price?.toStringAsFixed(2)}",
          style: AppStyles.bold16.copyWith(color: kPrimaryColor),
        ),
      ],
    );
  }
}
