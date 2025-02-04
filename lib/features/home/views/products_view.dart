import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/manager/Products_wish_list_cubit/products_wish_list_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_products_cubit/get_products_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/search_cubit/search_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/cart_bottom_sheet.dart';
import 'package:rakli_salons_app/features/home/views/widgets/product_card.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final List<ProductModel> products = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetProductsCubit>().getAllProducts();
    // Fetch wishlist when view initializes
    context.read<ProductsWishListCubit>().getProductsWishlist();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetProductsCubit, GetProductsState>(
      listener: (context, state) {
        if (state is GetProductsSuccess) {
          setState(() {
            products.clear();
            products.addAll(state.products);
          });
        }
      },
      builder: (context, state) {
        if (state is GetProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProductsFailed) {
          return Center(child: Text('Error: ${state.errMessage}'));
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 56),
                CustomAppBar(
                  backButtonColor: kPrimaryColor,
                  icon: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kFilterView);
                        },
                        icon: Icon(
                          Icons.filter_alt_sharp,
                          color: kPrimaryColor,
                          size: 34,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const CartBottomSheet(),
                          );
                        },
                        child: SvgPicture.asset(
                          Assets.assetsImagesCart,
                          width: 34,
                          height: 34,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Products",
                  textAlign: TextAlign.start,
                  style: AppStyles.bold24.copyWith(color: kbackGroundColor),
                ),
                const SizedBox(height: 18),
                CustomSearchField(
                  controller: _searchController,
                  onChanged: (query) {
                    context.read<SearchCubit>().search(
                          query: query,
                          category: 'products',
                        );
                  },
                ),

                // Products Grid View
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, searchState) {
                      if (searchState is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (searchState is SearchSuccess) {
                        return GridView.builder(
                          itemCount: searchState.results.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 280,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRouter.kProductDetailsView,
                                extra: searchState.results.products[index],
                              );
                            },
                            child: ProductCard(
                              product: searchState.results.products[index],
                            ),
                          ),
                        );
                      } else if (searchState is SearchFailed) {
                        return Center(
                            child: Text('Error: ${searchState.errMessage}'));
                      }

                      // Default view when no search is performed
                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 280,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(
                              AppRouter.kProductDetailsView,
                              extra: products[index],
                            );
                          },
                          child: ProductCard(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
