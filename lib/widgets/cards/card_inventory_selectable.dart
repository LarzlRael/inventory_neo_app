part of '../widgets.dart';

class CardInventorySelectableItems extends StatelessWidget {
  const CardInventorySelectableItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productsProvider = context.read<ProductsProvider>();
    final cardInventoryProvider = context.watch<CardInventoryProvider>();
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
              Text(
                'Productos Seleccionados: ${cardInventoryProvider.getProducts.length}',
                style: GoogleFonts.montserratAlternates().copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
          Flexible(
            child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              /* padding: const EdgeInsets.all(10), */
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              children: productsProvider.productsState.products.map<Widget>(
                (product) {
                  return CardInventorySelectable(
                    productModel: product,
                    cardInventoryProvider: cardInventoryProvider,
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class CardInventorySelectable extends StatefulWidget {
  final ProductModel productModel;
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
        elevation: 1,
        /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
        child: Column(
          /* mainAxisAlignment: MainAxisAlignment.spaceAround, */
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                widget.productModel.images.isNotEmpty
                    /* ? widget.productModel.images[0].src */
                    ? 'https://blog.hubstaff.com/wp-content/uploads/2016/05/Businesses-growth-post.png'
                    : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930',
                /* height: 75, */
                width: 65,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              subtitle: SimpleText(
                text: widget.productModel.name.length > 30
                    ? '${widget.productModel.name.substring(0, 30).toCapitalize()}...'
                    : widget.productModel.name.toCapitalize(),
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              title: SimpleText(
                text: widget.productModel.price,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                lightThemeColor: Colors.pink,
              ),
              trailing: Checkbox(
                value: isSelectable,
                onChanged: (value) {
                  setState(
                    () {
                      isSelectable = !isSelectable;
                    },
                  );
                  widget.cardInventoryProvider.addProduct(
                    widget.productModel,
                  );
                },
              ),
            ),
            /* Row(
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
                /* SizedBox(
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
                ), */
              ],
            ) */
          ],
        ),
      ),
    );
  }
}
