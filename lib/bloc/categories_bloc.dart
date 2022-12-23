part of 'blocs.dart';

class CategoriesBloc {
  static final CategoriesBloc _singleton = CategoriesBloc._internal();
  CategoriesBloc._internal();

  factory CategoriesBloc() {
    return _singleton;
  }
  final _ordersLists = StreamController<List<CategoriesModel>>.broadcast();

  Stream<List<CategoriesModel>> get categoriesStream => _ordersLists.stream;
  dispose() {
    _ordersLists.close();
  }

  getCategories() async {
    final res = await getAction('/products/categories');
    final orders = categoriesModelFromJson(res!.body);
    _ordersLists.sink.add(orders);
  }
}
