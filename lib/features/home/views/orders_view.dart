import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/manager/get_orders_cubit/get_orders_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

import '../../../core/customs/custom_app_bar.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
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
                S.of(context).orders,
                style: AppStyles.bold24.copyWith(color: Colors.black),
              ),
              icon: const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<GetOrdersCubit, GetOrdersState>(
                builder: (context, state) {
                  if (state is GetOrdersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetOrdersFailed) {
                    return Center(child: Text(state.errMessage));
                  }

                  if (state is GetOrdersSuccess) {
                    if (state.orders.isEmpty) {
                      return Center(
                        child: Text(
                          S.of(context).noOrdersFound,
                          style:
                              AppStyles.regular16.copyWith(color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order #${order.id}",
                                      style: AppStyles.bold16,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(order.state)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        order.state?.toUpperCase() ??
                                            S.of(context).notAvailable,
                                        style: AppStyles.medium14.copyWith(
                                          color: _getStatusColor(order.state),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${S.of(context).paymentLabel}: ${order.paymentType?.toUpperCase() ?? S.of(context).notAvailable}",
                                  style: AppStyles.regular14
                                      .copyWith(color: Colors.grey[600]),
                                ),
                                Text(
                                  "${S.of(context).dateLabel}: ${_formatDate(order.createdAt)}",
                                  style: AppStyles.regular14
                                      .copyWith(color: Colors.grey[600]),
                                ),
                                const Divider(height: 24),
                                if (order.items != null) ...[
                                  ...order.items!.map((item) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "http://89.116.110.219/storage/${item.image}",
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  color: Colors.grey[200],
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  color: Colors.grey[200],
                                                  child:
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.title ??
                                                        S
                                                            .of(context)
                                                            .unknownItem,
                                                    style: AppStyles.medium14,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    '${item.quantity}x \$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                                                    style: AppStyles.regular14
                                                        .copyWith(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              '\$${((item.price ?? 0) * (item.quantity ?? 0)).toStringAsFixed(2)}',
                                              style:
                                                  AppStyles.medium14.copyWith(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  const Divider(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).total,
                                        style: AppStyles.bold16,
                                      ),
                                      Text(
                                        '\$${order.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                                        style: AppStyles.bold16.copyWith(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
