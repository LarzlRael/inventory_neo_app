part of 'providers.dart';

class CategoriesMaterialProviders extends ChangeNotifier {
  CategoriesState categoriesState = CategoriesState();
  MaterialState materialesState = MaterialState();

  getFetchMaterialTags() async {
    materialesState = materialesState.copyWith(isLoading: true);
    final tags = await getAction('products/tags');
    materialesState = materialesState.copyWith(
        materiales: tagsModelFromJson(tags!.body), isLoading: false);
    notifyListeners();
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
  final List<CategoriesModel> categoriesList;
  CategoriesState({
    this.isLoading = false,
    this.categoriesList = const [],
  });
  CategoriesState copyWith({
    bool? isLoading,
    List<CategoriesModel>? categories,
  }) =>
      CategoriesState(
        isLoading: isLoading ?? this.isLoading,
        categoriesList: categories ?? this.categoriesList,
      );
}

class MaterialState {
  final bool isLoading;
  final List<TagsModel> materiales;
  MaterialState({
    this.isLoading = false,
    this.materiales = const [],
  });
  MaterialState copyWith({
    bool? isLoading,
    List<TagsModel>? materiales,
  }) =>
      MaterialState(
        isLoading: isLoading ?? this.isLoading,
        materiales: materiales ?? this.materiales,
      );
}
