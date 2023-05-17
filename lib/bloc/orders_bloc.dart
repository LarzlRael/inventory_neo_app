part of 'blocs.dart';

class OrdersBloc {
  static final OrdersBloc _singleton = OrdersBloc._internal();
  OrdersBloc._internal();

  factory OrdersBloc() {
    return _singleton;
  }
  final _ordersLists = StreamController<List<OrdersModel>>.broadcast();

  Stream<List<OrdersModel>> get ordersList => _ordersLists.stream;
  dispose() {
    _ordersLists.close();
  }

  /*  getOrders() async {
    final res = await getAction('/orders');
    final orders = ordersModelFromJson(res!.body);
    _ordersLists.sink.add(orders);
  } */
}
