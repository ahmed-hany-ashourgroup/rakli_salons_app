import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:rakli_salons_app/core/customs/custom_app_bar.dart';
import 'package:rakli_salons_app/core/customs/custom_button.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';

import '../../../core/theme/theme_constants.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<int> selectedSortOptions = [];
  double minPrice = 10, maxPrice = 87;
  double selectedRating = 3;

  @override
  Widget build(BuildContext context) {
    // Calculate responsive sizes
    final double titleSize = math.max(18, SizeConfig.defaultSize! * 0.8);
    final double subtitleSize = math.max(16, SizeConfig.defaultSize! * 0.7);
    final double textSize = math.max(14, SizeConfig.defaultSize! * 0.6);
    final double spacing = SizeConfig.screenhieght! * 0.02;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // App Bar
              CustomAppBar(
                backButtonColor: kPrimaryColor,
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      selectedSortOptions.clear();
                      minPrice = 10;
                      maxPrice = 87;
                      selectedRating = 3;
                    });
                  },
                  icon: Text(
                    "Reset",
                    style: AppStyles.light22.copyWith(
                      color: Colors.black,
                      fontSize: subtitleSize,
                    ),
                  ),
                ),
                title: Text(
                  "Filter",
                  style: AppStyles.bold24.copyWith(
                    color: Colors.black,
                    fontSize: titleSize,
                  ),
                ),
              ),

              // Scrollable Content
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: spacing),
                    Text(
                      'Sort Options',
                      style: AppStyles.bold20.copyWith(
                        color: kbackGroundColor,
                        fontSize: subtitleSize,
                      ),
                    ),
                    _buildCheckboxTile('Popularity', 1, textSize),
                    _buildCheckboxTile(
                        'Star Rating (highest first)', 2, textSize),
                    _buildCheckboxTile(
                        'Star Rating (lowest first)', 3, textSize),
                    _buildCheckboxTile('Price (lowest first)', 4, textSize),
                    _buildCheckboxTile('Price (highest first)', 5, textSize),
                    SizedBox(height: spacing),
                    Text(
                      'Price Range',
                      style: AppStyles.bold20.copyWith(
                        color: kbackGroundColor,
                        fontSize: subtitleSize,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${minPrice.round()} - \$${maxPrice.round()}',
                      style: AppStyles.light20.copyWith(
                        color: Colors.black,
                        fontSize: textSize,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "The average price is \$45",
                      style: AppStyles.light16.copyWith(
                        color: Colors.black,
                        fontSize: textSize,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: FlutterSlider(
                        values: [minPrice, maxPrice],
                        rangeSlider: true,
                        max: 100,
                        min: 10,
                        step: const FlutterSliderStep(step: 1),
                        handler: FlutterSliderHandler(
                          decoration: BoxDecoration(),
                          child: const Icon(Icons.circle, color: kPrimaryColor),
                        ),
                        rightHandler: FlutterSliderHandler(
                          decoration: BoxDecoration(),
                          child: const Icon(Icons.circle, color: kPrimaryColor),
                        ),
                        trackBar: FlutterSliderTrackBar(
                          activeTrackBarHeight: 5,
                          activeTrackBar: BoxDecoration(color: Colors.black),
                          inactiveTrackBar:
                              BoxDecoration(color: Colors.grey[300]),
                        ),
                        onDragging: (handlerIndex, lowerValue, upperValue) {
                          setState(() {
                            minPrice = lowerValue;
                            maxPrice = upperValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: spacing),
                    Text(
                      'Rating',
                      style: AppStyles.bold24.copyWith(
                        color: kbackGroundColor,
                        fontSize: subtitleSize,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: RatingBar.builder(
                        initialRating: selectedRating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: textSize * 1.5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            selectedRating = rating;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: spacing * 2),
                  ],
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                ),
                child: SizedBox(
                  height: math.max(48, SizeConfig.defaultSize! * 2),
                  child: CustomButton(
                    minwidth: 400,
                    borderRadius: 10,
                    title: Text(
                      'Apply Filters',
                      style: AppStyles.medium20.copyWith(
                        color: kSecondaryColor,
                        fontSize: subtitleSize,
                      ),
                    ),
                    onPressed: () {
                      // Apply filters action
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile(String title, int value, double fontSize) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppStyles.light16.copyWith(
          color: Colors.black,
          fontSize: fontSize,
        ),
      ),
      trailing: GestureDetector(
        onTap: () => _toggleOption(value),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: selectedSortOptions.contains(value)
                ? kPrimaryColor
                : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: selectedSortOptions.contains(value)
                  ? Colors.transparent
                  : Colors.black,
              width: 2,
            ),
          ),
          child: selectedSortOptions.contains(value)
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                )
              : null,
        ),
      ),
      onTap: () => _toggleOption(value),
    );
  }

  void _toggleOption(int value) {
    setState(() {
      if (selectedSortOptions.contains(value)) {
        selectedSortOptions.remove(value);
      } else {
        selectedSortOptions.add(value);
      }
    });
  }
}
