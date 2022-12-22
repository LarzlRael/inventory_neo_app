part of '../pages.dart';

class SellDetail extends StatelessWidget {
  const SellDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OrdersModel;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Detalle de venta',
        showTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            tranlateStatus(args.status),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 40,
              child: SimpleText(
                text:
                    '${args.billing.firstName[0].toUpperCase()}${args.billing.lastName[0].toUpperCase()}',
                fontSize: 25,
                lightThemeColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SimpleText(
              text: '${args.billing.firstName} ${args.billing.lastName}'
                  .toTitleCase(),
            ),
            SimpleText(
              text: args.billing.address1.toCapitalize(),
              top: 10,
              bottom: 10,
            ),
            SimpleText(
              text: 'Productos: ${args.lineItems.length}',
              fontWeight: FontWeight.bold,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: args.lineItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(args.lineItems[index].name.toCapitalize()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: 'Cantidad: ${args.lineItems[index].quantity}',
                        bottom: 5,
                      ),
                      Text('${args.lineItems[index].price}'),
                    ],
                  ),
                  leading: Image.network(
                    args.lineItems[0].imageProduct!.src == ""
                        ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                        : args.lineItems[0].imageProduct!.src,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
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
