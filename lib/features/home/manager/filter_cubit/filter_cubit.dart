import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState());

  void updateSortOptions(List<int> options) {
    emit(state.copyWith(
      selectedSortOptions: options,
      isActive: options.isNotEmpty ||
          state.rating != null ||
          state.priceRange != const RangeValues(10, 1000),
    ));
  }

  void updatePriceRange(RangeValues range) {
    emit(state.copyWith(
      priceRange: range,
      isActive: state.selectedSortOptions.isNotEmpty ||
          state.rating != null ||
          range != const RangeValues(10, 1000),
    ));
  }

  void updateRating(double? rating) {
    emit(state.copyWith(
      rating: rating,
      isActive: state.selectedSortOptions.isNotEmpty ||
          rating != null ||
          state.priceRange != const RangeValues(10, 1000),
    ));
  }

  void resetFilters() {
    emit(const FilterState());
  }
}
