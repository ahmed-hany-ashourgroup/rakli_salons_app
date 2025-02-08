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
import 'package:rakli_salons_app/features/home/manager/filter_cubit/filter_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_products_cubit/get_products_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/search_cubit/search_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/cart_bottom_sheet.dart';
import 'package:rakli_salons_app/features/home/views/widgets/filter_bottom_sheet.dart';
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
    context.read<ProductsWishListCubit>().getProductsWishlist();

    // Apply any existing filters on init
    final filterState = context.read<FilterCubit>().state;
    if (filterState.isActive) {
      _applyFilters(filterState);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters(FilterState filterState) {
    context.read<SearchCubit>().search(
          query: _searchController.text,
          category: 'products',
          minPrice: filterState.priceRange.start.round(),
          maxPrice: filterState.priceRange.end.round(),
          rating: filterState.rating?.round(),
          sortOptions: filterState.selectedSortOptions,
        );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => BlocProvider.value(
          value: context.read<FilterCubit>(),
          child: const FilterBottomSheet(),
        ),
      ),
    ).then((_) {
      // Apply filters when bottom sheet is closed
      final filterState = context.read<FilterCubit>().state;
      if (filterState.isActive) {
        _applyFilters(filterState);
      } else {
        // If filters are not active, perform a regular search
        context.read<SearchCubit>().search(
              query: _searchController.text,
              category: 'products',
            );
      }
    });
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

          // Apply any existing filters after products are loaded
          final filterState = context.read<FilterCubit>().state;
          if (filterState.isActive) {
            _applyFilters(filterState);
          }
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
                      BlocBuilder<FilterCubit, FilterState>(
                        builder: (context, state) {
                          return Badge(
                            isLabelVisible: state.isActive,
                            backgroundColor: kPrimaryColor,
                            child: IconButton(
                              onPressed: _showFilterBottomSheet,
                              icon: Icon(
                                Icons.filter_alt_sharp,
                                color: kPrimaryColor,
                                size: 34,
                              ),
                            ),
                          );
                        },
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
                    final filterState = context.read<FilterCubit>().state;
                    if (filterState.isActive) {
                      _applyFilters(filterState);
                    } else {
                      context.read<SearchCubit>().search(
                            query: query,
                            category: 'products',
                          );
                    }
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, filterState) {
                    if (filterState.isActive) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              if (filterState.priceRange !=
                                  const RangeValues(10, 1000))
                                _buildFilterChip(
                                  '\$${filterState.priceRange.start.round()} - \$${filterState.priceRange.end.round()}',
                                  onDeleted: () {
                                    context
                                        .read<FilterCubit>()
                                        .updatePriceRange(
                                            const RangeValues(10, 1000));
                                    _applyFilters(
                                        context.read<FilterCubit>().state);
                                  },
                                ),
                              if (filterState.rating != null)
                                _buildFilterChip(
                                  '${filterState.rating} Stars',
                                  onDeleted: () {
                                    context
                                        .read<FilterCubit>()
                                        .updateRating(null);
                                    _applyFilters(
                                        context.read<FilterCubit>().state);
                                  },
                                ),
                              ...filterState.selectedSortOptions.map((option) {
                                String label = '';
                                switch (option) {
                                  case 1:
                                    label = 'Price: Low to High';
                                    break;
                                  case 2:
                                    label = 'Price: High to Low';
                                    break;
                                  case 3:
                                    label = 'Most Popular';
                                    break;
                                  case 4:
                                    label = 'Best Rating';
                                    break;
                                  case 5:
                                    label = 'Newest';
                                    break;
                                }
                                return _buildFilterChip(
                                  label,
                                  onDeleted: () {
                                    final newOptions = List<int>.from(
                                        filterState.selectedSortOptions)
                                      ..remove(option);
                                    context
                                        .read<FilterCubit>()
                                        .updateSortOptions(newOptions);
                                    _applyFilters(
                                        context.read<FilterCubit>().state);
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, searchState) {
                      if (searchState is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (searchState is SearchSuccess) {
                        final filteredProducts = searchState.results.products;
                        if (filteredProducts.isEmpty) {
                          return Center(
                            child: Text(
                              'No products found',
                              style: AppStyles.regular14
                                  .copyWith(color: Colors.grey),
                            ),
                          );
                        }
                        return _buildProductsGrid(filteredProducts);
                      } else if (searchState is SearchFailed) {
                        return Center(
                            child: Text('Error: ${searchState.errMessage}'));
                      }
                      return _buildProductsGrid(products);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(String label, {required VoidCallback onDeleted}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(
          label,
          style: AppStyles.regular14.copyWith(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
        deleteIcon: const Icon(Icons.close, size: 18),
        deleteIconColor: Colors.white,
        onDeleted: onDeleted,
      ),
    );
  }

  Widget _buildProductsGrid(List<ProductModel> items) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 280,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          GoRouter.of(context).push(
            AppRouter.kProductDetailsView,
            extra: items[index],
          );
        },
        child: ProductCard(
          product: items[index],
        ),
      ),
    );
  }
}
