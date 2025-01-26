part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final SearchResults results;

  SearchSuccess({required this.results});
}

final class SearchFailed extends SearchState {
  final String errMessage;

  SearchFailed({required this.errMessage});
}
