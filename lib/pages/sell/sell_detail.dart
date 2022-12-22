part of '../pages.dart';

class SellDetail extends StatefulWidget {
  final OrdersModel args;
  const SellDetail({
    super.key,
    required this.args,
  });

  @override
  State<SellDetail> createState() => _SellDetailState();
}

class _SellDetailState extends State<SellDetail> {
  late String dropdownValue;
  @override
  void initState() {
    dropdownValue = statusList[widget.args.status]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            tranlateStatus(widget.args.status),
            const SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 40,
              child: SimpleText(
                text:
                    '${widget.args.billing.firstName[0].toUpperCase()}${widget.args.billing.lastName[0].toUpperCase()}',
                fontSize: 25,
                lightThemeColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SimpleText(
              text:
                  '${widget.args.billing.firstName} ${widget.args.billing.lastName}'
                      .toTitleCase(),
            ),
            SimpleText(
              text: widget.args.billing.address1.toCapitalize(),
              top: 10,
              bottom: 10,
            ),
            SimpleText(
              text: 'Productos: ${widget.args.lineItems.length}',
              fontWeight: FontWeight.bold,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) async {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
                await updateStatus(widget.args.id, value);
              },
              items:
                  statusListList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.args.lineItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(widget.args.lineItems[index].name.toCapitalize()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text:
                            'Cantidad: ${widget.args.lineItems[index].quantity}',
                        bottom: 5,
                      ),
                      Text('${widget.args.lineItems[index].price}'),
                    ],
                  ),
                  leading: Image.network(
                    widget.args.lineItems[0].imageProduct!.src == ""
                        ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                        : widget.args.lineItems[0].imageProduct!.src,
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

  updateStatus(orderId, dropdownValue) async {
    final orderBloc = OrdersBloc();
    final res = await putAction(
        'orders/$orderId', {'status': statusListTransalteEn[dropdownValue]});

    if (res!.statusCode == 200) {
      orderBloc.getOrders();
      GlobalSnackBar.show(context, 'Estado actualizado',
          backgroundColor: Colors.green);
      /* Navigator.pop(context); */
    } else {
      GlobalSnackBar.show(context, 'Error al cambiar estado',
          backgroundColor: Colors.red);
    }
  }
}
