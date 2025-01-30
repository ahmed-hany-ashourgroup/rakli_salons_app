part of 'add_edit_prodcut_cubit.dart';

@immutable
abstract class AddEditProductState {}

class AddEditProductInitial extends AddEditProductState {}

class AddEditProductLoading extends AddEditProductState {}

class AddEditProductSuccess extends AddEditProductState {}

class AddEditProductFailed extends AddEditProductState {
  final String errMessage;

  AddEditProductFailed({required this.errMessage});
}
