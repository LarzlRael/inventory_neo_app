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

  Future<List<OrdersModel>> getOrderByClient(String userEmail) async {
    final response = await getAction(
      'orders?search=$userEmail',
    );

    return ordersModelFromJson(response!.body);
  }
}

class OrderState {
  final bool isLoading;
  final List<OrdersModel> orders;
  OrderState({
    this.isLoading = false,
    this.orders = const [],
  });
  copyWith({
    bool? isLoading,
    List<OrdersModel>? orders,
  }) =>
      OrderState(
        isLoading: isLoading ?? this.isLoading,
        orders: orders ?? this.orders,
      );
}
