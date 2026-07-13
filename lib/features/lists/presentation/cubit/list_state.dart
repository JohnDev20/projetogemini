import '../../domain/models/shopping_list.dart';

abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {}

class ListLoaded extends ListState {
  final List<ShoppingList> activeLists;
  ListLoaded(this.activeLists);
}

class ListError extends ListState {
  final String message;
  ListError(this.message);
}
