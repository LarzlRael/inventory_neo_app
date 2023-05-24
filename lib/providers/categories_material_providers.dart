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

  Future<bool> addOrEditCategory(
    Map<String, dynamic> body, {
    int? idCategory,
  }) async {
    final url = idCategory != null
        ? 'products/categories/$idCategory'
        : 'products/categories/';
    final method = idCategory != null ? RequestType.put : RequestType.post;
    final clientRequest = await Request.sendRequestWithToken(
      method,
      url,
      body,
    );
    final response = categoryModelFromJson(clientRequest!.body);

    if (idCategory != null) {
      categoriesState = categoriesState.copyWith(
        categories: [
          ...categoriesState.categoriesList
              .where((element) => element.id != idCategory)
              .toList(),
          response,
        ],
        isLoading: false,
      );
      notifyListeners();
      return validateStatus(clientRequest.statusCode);
    }
    categoriesState = categoriesState.copyWith(
      categories: [
        ...categoriesState.categoriesList,
        response,
      ],
      isLoading: false,
    );

    notifyListeners();
    return validateStatus(clientRequest.statusCode);
  }

  Future<bool> deleteCategory(int idCategory) async {
    final clientRequest =
        await deleteAction('products/categories/$idCategory?force=true');
    if (validateStatus(clientRequest!.statusCode)) {
      categoriesState = categoriesState.copyWith(
        isLoading: false,
        categories: categoriesState.categoriesList
            .where((element) => element.id != idCategory)
            .toList(),
      );
    }
    notifyListeners();
    return validateStatus(clientRequest.statusCode);
  }

  /* updateCategory(
    int idCategory,
    Map<String, dynamic> json,
  ) async {
    final updateCategory =
        await putAction('products/categories/$idCategory', json);
    responsePost(
      validateStatus(updateCategory!.statusCode),
      'Categoria actualizada',
      'Error al actualizar registro',
    );
  }

  postCategory(
    Map<String, dynamic> json,
  ) async {
    final newCategory = await postAction('products/categories/', json);

    responsePost(
      validateStatus(newCategory!.statusCode),
      'Categoria registrada',
      'Error al registrar',
    );
  } */
}

class CategoriesState {
  final bool isLoading;
  final List<CategorieModel> categoriesList;
  CategoriesState({
    this.isLoading = false,
    this.categoriesList = const [],
  });
  CategoriesState copyWith({
    bool? isLoading,
    List<CategorieModel>? categories,
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
