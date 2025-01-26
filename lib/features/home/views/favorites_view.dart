import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/product_model.dart';
import 'package:rakli_salons_app/features/home/views/widgets/product_card.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: kTextColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: kTextColor,
          tabs: const [
            Tab(text: "Products"),
            Tab(text: "Salons"),
            Tab(text: "Stylists"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGrid([]), // Stylists wishlist (not implemented yet)
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductCard(product: products[index]),
      ),
    );
  }

  Widget _buildGrid(List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        children: items,
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.name,
    required this.image,
    required this.rating,
    this.subtitle = "",
  });

  final String name;
  final String image;
  final double rating;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              opacity: 0.7,
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            color: Colors.black,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style:
                            AppStyles.bold16.copyWith(color: kSecondaryColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
