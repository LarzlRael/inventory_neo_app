part of '../widgets.dart';

class CardInventorySelectableItems extends StatefulWidget {
  const CardInventorySelectableItems({super.key});

  @override
  State<CardInventorySelectableItems> createState() =>
      _CardInventorySelectableItemsState();
}

class _CardInventorySelectableItemsState
    extends State<CardInventorySelectableItems> {
  List<ProductsModel> products = [];
  double total = 0;
  addProduct(ProductsModel product) {
    if (products.contains(product)) {
      products.remove(product);
    } else {
      products.add(product);
    }
    setState(() {
      if (products.isEmpty) {
        total = 0;
      } else {
        total = products
            .map((e) => double.parse(e.price))
            .reduce((value, element) => value + element);
        products = products;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsServices = ProductsServices();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Productos Seleccionados: ${products.length}'),
          Text('Productos Seleccionados: ${total}'),
          FutureBuilder(
            future: productsServices.getAllProducts(),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<ProductsModel>> snapshot,
            ) {
              if (!snapshot.hasData) {
                return simpleLoading();
              }

              return Flexible(
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
                      callback: addProduct,
                      productModel: product,
                      enableMultiSelect: true,
                    );
                  },
                ),
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
  final void Function(ProductsModel product) callback;
  final bool enableMultiSelect;
  const CardInventorySelectable({
    super.key,
    required this.productModel,
    required this.enableMultiSelect,
    required this.callback,
  });

  @override
  State<CardInventorySelectable> createState() =>
      _CardInventorySelectableState();
}

class _CardInventorySelectableState extends State<CardInventorySelectable> {
  bool isSelectable = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.enableMultiSelect) {
          setState(() {
            isSelectable = !isSelectable;
          });
          widget.callback(widget.productModel);
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
            /* height: MediaQuery.of(context).size.width * 0.9, */
            color: isSelectable ? Colors.blue : Colors.white,
            child: Card(
              elevation: 0,
              /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
              child: Container(
                /* color: _isSelected ? Colors.blue : Colors.white, */
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        widget.productModel.images.isNotEmpty
                            ? widget.productModel.images[0].src
                            : 'https://aeasa.com.mx/wp-content/uploads/2020/02/SIN-IMAGEN.jpg',
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                              text: widget.productModel.name,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                        widget.enableMultiSelect
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: isSelectable,
                                  onChanged: (value) {
                                    /*  widget.callback(widget.productModel);
                                    setState(() {
                                      isSelectable = value!;
                                    }); */
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          /* Container(
            color: Colors.blue.withOpacity(.7),
          ), */
        ],
      ),
    );
  }
}
