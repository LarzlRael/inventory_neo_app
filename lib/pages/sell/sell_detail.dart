part of '../pages.dart';

class SellDetail extends StatefulWidget {
  final OrderModel orderModel;
  const SellDetail({
    super.key,
    required this.orderModel,
  });

  @override
  State<SellDetail> createState() => _SellDetailState();
}

class _SellDetailState extends State<SellDetail> {
  late String dropdownValue;

  late GlobalProvider globalProvider;
  late OrderProvider orderProvider;
  @override
  void initState() {
    super.initState();
    dropdownValue = statusList[widget.orderModel.status]!;
    globalProvider = context.read<GlobalProvider>();
    orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Detalle de venta',
        showTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              tranlateStatus(widget.orderModel.status),
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 45,
                child: SimpleText(
                  text:
                      '${widget.orderModel.billing.firstName[0].toUpperCase()}${widget.orderModel.billing.lastName[0].toUpperCase()}',
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              SimpleText(
                text:
                    '${widget.orderModel.billing.firstName} ${widget.orderModel.billing.lastName}'
                        .toTitleCase(),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              SimpleText(
                text: widget.orderModel.billing.address1.toCapitalize(),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
              ),
              SimpleText(
                text: widget.orderModel.billing.phone,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  await updateStatus(widget.orderModel.id, value);
                },
                items: statusListList
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
              ),
              SimpleText(
                text:
                    'Cantidad de productos: ${widget.orderModel.lineItems.length}',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.orderModel.lineItems.length,
                itemBuilder: (_, int index) => ItemDetailSell(
                  lineItem: widget.orderModel.lineItems[index],
                  onSelected: (lineItem) {
                    context.push(
                      '/item_detail',
                      extra: lineItem.productId,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateStatus(orderId, dropdownValue) async {
    orderProvider
        .updateStatus(orderId, statusListTransalteEn[dropdownValue]!)
        .then((value) {
      if (value) {
        globalProvider.showSnackBar(
          context,
          'Estado actualizado',
          backgroundColor: Colors.green,
        );
        context.pop();
      } else {
        globalProvider.showSnackBar(
          context,
          'Error al cambiar estado',
          backgroundColor: Colors.red,
        );
      }
    });
  }
}

class ItemDetailSell extends StatelessWidget {
  final LineItem lineItem;
  final void Function(LineItem lineItem)? onSelected;
  const ItemDetailSell({
    super.key,
    required this.lineItem,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          if (onSelected != null) {
            onSelected!(lineItem);
          }
        },
        title: SimpleText(
          text: lineItem.name.toCapitalize(),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: 'Cantidad: ${lineItem.quantity}',
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              fontSize: 12,
            ),
            SimpleText(
              text: '${lineItem.price} bs.',
              color: Colors.grey,
            ),
          ],
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            lineItem.imageProduct!.src == ""
                ? "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg"
                : lineItem.imageProduct!.src,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
