part of 'providers.dart';

class OrderProvider with ChangeNotifier {
  OrderState orderState = OrderState();
  getOrders() async {
    orderState = orderState.copyWith(isLoading: true);
    final res = await getAction('/orders');
    final orders = ordersModelFromJson(res!.body);
    orderState = orderState.copyWith(
      orders: orders,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<bool> updateStatus(int idOrder, String dropdownValue) async {
    final response =
        await putAction('orders/$idOrder', {'status': dropdownValue});
    final orderConverted = orderModelFromJson(response!.body);
    orderState = orderState.copyWith(
      isLoading: true,
      orders: orderState.orders
          .map(
              (order) => order.id == orderConverted.id ? orderConverted : order)
          .toList(),
    );
    notifyListeners();
    return validateStatus(response.statusCode);
  }

  Future<List<OrderModel>> getOrderByClient(String userEmail) async {
    final response = await getAction(
      'orders?search=$userEmail',
    );

    return ordersModelFromJson(response!.body);
  }
}

class OrderState {
  final bool isLoading;
  final List<OrderModel> orders;
  OrderState({
    this.isLoading = false,
    this.orders = const [],
  });
  copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
  }) =>
      OrderState(
        isLoading: isLoading ?? this.isLoading,
        orders: orders ?? this.orders,
      );
}
