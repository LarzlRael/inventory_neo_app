part of 'providers.dart';

class CategoriesMaterialProviders extends ChangeNotifier {
  List<TagsModel> _materiales = [];
  CategoriesState categoriesState = CategoriesState();

  set setMateriales(List<TagsModel> tags) {
    _materiales = tags;
    notifyListeners();
  }

  get getMateriales => _materiales;

  getFetchMaterialTagsFetch() async {
    final tags = await getAction('products/tags');
    _materiales = tagsModelFromJson(tags!.body);
  }

  Future<void> getFetchCategories() async {
    categoriesState = categoriesState.copyWith(isLoading: true);
    final res = await getAction('products/categories');
    final categories = categoriesModelFromJson(res!.body);
    categoriesState = categoriesState.copyWith(
      categories: categories,
      isLoading: false,
    );
    notifyListeners();
  }
}

class CategoriesState {
  final bool isLoading;
  final List<CategoriesModel> categories;
  CategoriesState({
    this.isLoading = false,
    this.categories = const [],
  });
  CategoriesState copyWith({
    bool? isLoading,
    List<CategoriesModel>? categories,
  }) =>
      CategoriesState(
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
      );
}
