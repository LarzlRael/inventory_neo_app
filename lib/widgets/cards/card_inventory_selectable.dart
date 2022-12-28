part of '../widgets.dart';

class CardInventorySelectableItems extends StatelessWidget {
  const CardInventorySelectableItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsServices = ProductsServices();
    final cardInventoryProvider =
        Provider.of<CardInventoryProvider>(context, listen: true);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left_sharp),
              ),
              SimpleText(
                text:
                    'Productos Seleccionados: ${cardInventoryProvider.getProducts.length}',
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
          FutureBuilder(
            future: productsServices.getAllProducts(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<ProductsModel>> snapshot,
            ) {
              if (!snapshot.hasData) {
                return simpleLoading();
              }

              /* return Flexible(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, index) {
                    final product = snapshot.data![index];
                    return CardInventorySelectable(
                      productModel: product,
                      cardInventoryProvider: cardInventoryProvider,
                    );
                  },
                ),
              ); */
              return Flexible(
                child: GridView.count(
                    /* shrinkWrap: true, */
                    /* physics: NeverScrollableScrollPhysics(), */
                    /* padding: const EdgeInsets.all(10), */
                    childAspectRatio: 3 / 2,
                    crossAxisCount: 2,
                    children: snapshot.data!.map<Widget>(
                      (product) {
                        return CardInventorySelectable(
                          productModel: product,
                          cardInventoryProvider: cardInventoryProvider,
                        );
                      },
                    ).toList()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CardInventorySelectable extends StatefulWidget {
  final ProductsModel productModel;
  final CardInventoryProvider cardInventoryProvider;
  const CardInventorySelectable({
    super.key,
    required this.productModel,
    required this.cardInventoryProvider,
  });

  @override
  State<CardInventorySelectable> createState() =>
      _CardInventorySelectableState();
}

class _CardInventorySelectableState extends State<CardInventorySelectable> {
  late bool isSelectable;

  @override
  void initState() {
    setState(
      () {
        isSelectable = widget.cardInventoryProvider.getListProductsId
            .contains(widget.productModel.id);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelectable = !isSelectable;
        });

        widget.cardInventoryProvider.addProduct(widget.productModel);
      },
      child: Card(
        elevation: 5,
        /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
        child: Column(
          /* mainAxisAlignment: MainAxisAlignment.spaceAround, */
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.productModel.images.isNotEmpty
                    ? widget.productModel.images[0].src
                    : 'https://aeasa.com.mx/wp-content/uploads/2020/02/SIN-IMAGEN.jpg',
                /* height: 75, */
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    /* mainAxisAlignment: MainAxisAlignment.start, */
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        bottom: 2,
                        top: 2,
                        text: widget.productModel.price,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        lightThemeColor: Colors.pink,
                      ),
                      SimpleText(
                        text: widget.productModel.name.toCapitalize(),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: isSelectable,
                    onChanged: (value) {
                      setState(() {
                        isSelectable = !isSelectable;
                      });

                      widget.cardInventoryProvider
                          .addProduct(widget.productModel);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
