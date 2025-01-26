import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/assets.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _navigateToNextView();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  void _navigateToNextView() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        GoRouter.of(context).go(AppRouter.kHomeView);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFE4D6), // Darker beige
              Color(0xFFFFF5EC), // Light beige
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: SizedBox(
                  height: 300, // Reduced size for better frame performance
                  width: 300,
                  child: Image.asset(
                    Assets.assetsImagesLogopng,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _scaleAnimation,
                child: SvgPicture.asset(
                  Assets.assetsImagesLoading,
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
