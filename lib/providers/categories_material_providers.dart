import 'package:flutter/material.dart';
import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/services/services.dart';

class CategoriesMaterialProviders extends ChangeNotifier {
  List<CategoriesModel> _categories = [];
  List<TagsModel> _materiales = [];

  set setCategories(List<CategoriesModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  set setMateriales(List<TagsModel> tags) {
    _materiales = tags;
    notifyListeners();
  }

  get getCategories => _categories;
  get getMateriales => _materiales;

  setCategoriesWithFetch() async {
    final categories = await getAction('products/categories');
    setCategories = categoriesModelFromJson(categories!.body);
  }

  setMaterialTagsFetch() async {
    final tags = await getAction('products/tags');
    _materiales = tagsModelFromJson(tags!.body);
  }
}
