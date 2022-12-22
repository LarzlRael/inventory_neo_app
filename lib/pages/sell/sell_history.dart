part of '../pages.dart';

class SellHistory extends StatelessWidget {
  const SellHistory({super.key});
  @override
  Widget build(BuildContext context) {
    final orderBloc = OrdersBloc();
    orderBloc.getOrders();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Historial de ventas',
        showTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            /* SimpleText(
              text: 'Historial de ventas',
              top: 20,
            ), */
            /* SellHistoryCard(),
            SellHistoryCard(),
            SellHistoryCard(), */
            StreamBuilder(
              stream: orderBloc.odersList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrdersModel>> snapshot) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SellHistoryCard(
                        order: snapshot.data![index],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SellHistoryCard extends StatelessWidget {
  final OrdersModel order;
  const SellHistoryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'sell_detail',
          arguments: order,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Image.network(
              order.lineItems[0].imageProduct!.src == ""
                  ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                  : order.lineItems[0].imageProduct!.src,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SimpleText(
                  text: order.lineItems[0].name.toCapitalize(),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                SimpleText(
                  text: '${order.billing.firstName} ${order.billing.lastName}'
                      .toTitleCase(),
                  fontSize: 14,
                  top: 3,
                  bottom: 3,
                  fontWeight: FontWeight.w500,
                ),
                SimpleText(
                  text: '${order.lineItems.length.toString()} artículos',
                  lightThemeColor: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const Spacer(),
            tranlateStatus(order.status),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

Widget tranlateStatus(String status) {
  return SimpleText(
    text: statusList[status]!,
    lightThemeColor: Colors.grey,
    fontWeight: FontWeight.w800,
  );
}

Future<List<OrdersModel>> getOrders() async {
  final res = await getAction('/orders');
  return ordersModelFromJson(res!.body);
}

class OrdersBloc {
  static final OrdersBloc _singleton = OrdersBloc._internal();
  OrdersBloc._internal();

  factory OrdersBloc() {
    return _singleton;
  }
  final _ordersLists = StreamController<List<OrdersModel>>.broadcast();

  Stream<List<OrdersModel>> get odersList => _ordersLists.stream;
  dispose() {
    _ordersLists.close();
  }

  getOrders() async {
    final res = await getAction('/orders');
    final orders = ordersModelFromJson(res!.body);
    _ordersLists.sink.add(orders);
  }
}
