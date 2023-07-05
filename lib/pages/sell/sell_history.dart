part of '../pages.dart';

class SellHistory extends StatefulWidget {
  const SellHistory({super.key});

  @override
  State<SellHistory> createState() => _SellHistoryState();
}

class _SellHistoryState extends State<SellHistory> {
  late OrderProvider orderProvider;
  @override
  void initState() {
    super.initState();
    orderProvider = context.read<OrderProvider>();
    orderProvider.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Historial de ventas',
        showTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<OrderProvider>(
          builder: (context, state, widget) {
            final orders = state.orderState.orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (_, int index) {
                return SellHistoryCard(
                  order: orders[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SellHistoryCard extends StatelessWidget {
  final OrderModel order;
  const SellHistoryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: (() {
          context.push(
            '/sell_detail',
            extra: order,
          );
        }),
        leading: Image.network(
          /* changed this */
          /* order.lineItems[0].imageProduct!.src == ""
              ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
              : order.lineItems[0].imageProduct!.src, */
          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: SimpleText(
          text: order.lineItems[0].name.length > 20
              ? '${order.lineItems[0].name.substring(0, 20).toCapitalize()}...'
              : order.lineItems[0].name.toCapitalize(),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: '${order.billing.firstName} ${order.billing.lastName}'
                  .toTitleCase(),
              fontSize: 14,
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              fontWeight: FontWeight.w500,
            ),
            SimpleText(
              text: '${order.lineItems.length.toString()} artículos',
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        trailing: tranlateStatus(order.status),
      ),
    );
  }
}

Widget tranlateStatus(String status) {
  return SimpleText(
    text: statusList[status]!,
    color: Colors.grey,
    fontWeight: FontWeight.w800,
  );
}
