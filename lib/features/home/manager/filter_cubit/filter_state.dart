part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final RangeValues priceRange;
  final double? rating;
  final List<int> selectedSortOptions;
  final bool isActive;

  const FilterState({
    this.priceRange = const RangeValues(10, 1000),
    this.rating,
    this.selectedSortOptions = const [],
    this.isActive = false,
  });

  FilterState copyWith({
    RangeValues? priceRange,
    double? rating,
    List<int>? selectedSortOptions,
    bool? isActive,
  }) {
    return FilterState(
      priceRange: priceRange ?? this.priceRange,
      rating: rating ?? this.rating,
      selectedSortOptions: selectedSortOptions ?? this.selectedSortOptions,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [priceRange, rating, selectedSortOptions, isActive];
}
