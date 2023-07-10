abstract class CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<String>? categories;
  CategoryLoadedState(this.categories);
}

class CategoryErrorState extends CategoryState {
  String? error;
  CategoryErrorState(this.error);
}
