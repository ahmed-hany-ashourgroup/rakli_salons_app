import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_bottom_nav.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _HomeContent(),
    // const ProductsView(),
    // const MapNearbyView(),
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) => DeleteAccountCubit(),
    //     ),
    //     BlocProvider(
    //       create: (context) => LogOutCubit(),
    //     ),
    //   ],
    //   child: const ProfileView(),
    // ),
  ];

  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index); // Change page without animation
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content (PageView)
          PageView(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Disable swipe gesture
            children: _pages,
          ),

          // Floating Bottom Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: SizeConfig.screenhieght! * 0.33,
          //   child: TopScrollSection(),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(height: 29),
          //       Row(
          //         children: [
          //           Hero(
          //             tag: 'searchField',
          //             child: SizedBox(
          //               width: SizeConfig.screenwidth! * 0.8,
          //               child: CustomSearchField(
          //                 onTap: () {
          //                   Navigator.of(context).push(
          //                     PageRouteBuilder(
          //                       pageBuilder:
          //                           (context, animation, secondaryAnimation) =>
          //                               const SearchView(),
          //                       transitionsBuilder: (context, animation,
          //                           secondaryAnimation, child) {
          //                         return FadeTransition(
          //                           opacity: animation,
          //                           child: child,
          //                         );
          //                       },
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ),
          //           const Spacer(),
          //           CircleAvatar(
          //             radius: 20,
          //             backgroundColor: kSecondaryColor,
          //             child: const Icon(Icons.filter_alt, color: kPrimaryColor),
          //           )
          //         ],
          //       ),
          //       const SizedBox(height: 29),
          //       ProductList(),
          //       const SizedBox(height: 29),
          //       TopSalonsList(),
          //       const SizedBox(height: 29),
          //       PopularList(),
          //       const SizedBox(height: 120),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
