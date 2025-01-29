import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/customs/custom_admin_appbar.dart';
import 'package:rakli_salons_app/core/customs/custom_bottom_nav.dart';
import 'package:rakli_salons_app/core/customs/custom_drawer.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';
import 'package:rakli_salons_app/features/home/views/appointments_view.dart';
import 'package:rakli_salons_app/features/home/views/home_content.dart';
import 'package:rakli_salons_app/features/home/views/profile_view.dart';
import 'package:rakli_salons_app/features/home/views/services_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const AppointmentsView(),
    BlocProvider(
      create: (context) => GetServicesCubit(),
      child: const ServicesView(),
    ),
    const ProfileView()
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEFEF),
      drawer: CustomDrawer(),
      key: _scaffoldKey,
      appBar: CustomAdminAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
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
