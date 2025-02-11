import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/manager/filter_cubit/filter_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _currentRangeValues = const RangeValues(10, 1000);
  double? _selectedRating;
  final List<int> _selectedSortOptions = [];

  @override
  void initState() {
    super.initState();
    final filterState = context.read<FilterCubit>().state;
    _currentRangeValues = filterState.priceRange;
    _selectedRating = filterState.rating;
    _selectedSortOptions.addAll(filterState.selectedSortOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPriceRangeSection(),
                  const SizedBox(height: 24),
                  _buildRatingSection(),
                  const SizedBox(height: 24),
                  _buildSortOptionsSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            S.of(context).filter,
            style: AppStyles.bold20.copyWith(color: kPrimaryColor),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              context.read<FilterCubit>().resetFilters();
              setState(() {
                _currentRangeValues = const RangeValues(10, 1000);
                _selectedRating = null;
                _selectedSortOptions.clear();
              });
            },
            child: Text(
              S.of(context).reset,
              style: AppStyles.regular14.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).priceRange,
          style: AppStyles.bold16.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${_currentRangeValues.start.round()}',
              style: AppStyles.regular14.copyWith(color: Colors.grey[600]),
            ),
            Text(
              '\$${_currentRangeValues.end.round()}',
              style: AppStyles.regular14.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: 10,
          max: 1000,
          divisions: 99,
          activeColor: kPrimaryColor,
          inactiveColor: Colors.grey[200],
          labels: RangeLabels(
            '\$${_currentRangeValues.start.round()}',
            '\$${_currentRangeValues.end.round()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).rating,
          style: AppStyles.bold16.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            final rating = index + 1.0;
            return _buildRatingChip(rating);
          }),
        ),
      ],
    );
  }

  Widget _buildRatingChip(double rating) {
    final isSelected = _selectedRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRating = isSelected ? null : rating;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kPrimaryColor : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: isSelected ? Colors.white : Colors.amber,
            ),
            const SizedBox(width: 4),
            Text(
              rating.toString(),
              style: AppStyles.regular14.copyWith(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).sortBy,
          style: AppStyles.bold16.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildSortOptionChip(1, S.of(context).sortByPriceLowToHigh),
            _buildSortOptionChip(2, S.of(context).sortByPriceHighToLow),
            _buildSortOptionChip(3, S.of(context).sortByMostPopular),
            _buildSortOptionChip(4, S.of(context).sortByBestRating),
            _buildSortOptionChip(5, S.of(context).sortByNewest),
          ],
        ),
      ],
    );
  }

  Widget _buildSortOptionChip(int option, String label) {
    final isSelected = _selectedSortOptions.contains(option);
    return FilterChip(
      selected: isSelected,
      label: Text(label),
      labelStyle: AppStyles.regular14.copyWith(
        color: isSelected ? Colors.white : Colors.black87,
      ),
      backgroundColor: Colors.grey[100],
      selectedColor: kPrimaryColor,
      checkmarkColor: Colors.white,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedSortOptions.add(option);
          } else {
            _selectedSortOptions.remove(option);
          }
        });
      },
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Text(
                S.of(context).cancel,
                style: AppStyles.medium14.copyWith(color: Colors.grey[600]),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                context.read<FilterCubit>()
                  ..updatePriceRange(_currentRangeValues)
                  ..updateRating(_selectedRating)
                  ..updateSortOptions(_selectedSortOptions);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                S.of(context).apply,
                style: AppStyles.medium14.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
