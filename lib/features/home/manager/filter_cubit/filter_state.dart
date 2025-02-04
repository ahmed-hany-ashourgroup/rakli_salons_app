part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final List<int> selectedSortOptions;
  final RangeValues priceRange;
  final double? rating;
  final bool isActive;

  const FilterState({
    this.selectedSortOptions = const [],
    this.priceRange = const RangeValues(10, 1000),
    this.rating = 3,
    this.isActive = false,
  });

  FilterState copyWith({
    List<int>? selectedSortOptions,
    RangeValues? priceRange,
    double? rating,
    bool? isActive,
  }) {
    return FilterState(
      selectedSortOptions: selectedSortOptions ?? this.selectedSortOptions,
      priceRange: priceRange ?? this.priceRange,
      rating: rating,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props =>
      [selectedSortOptions, priceRange, rating, isActive];
}
