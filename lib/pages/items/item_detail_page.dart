part of '../pages.dart';

class ItemDetailPage extends StatefulWidget {
  final ProductModel productModel;

  const ItemDetailPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    productProvider.loadProduct(widget.productModel.id);
  }

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider = context.read<CardInventoryProvider>();
    final productsProvider = context.read<ProductsProvider>();
    final globalProvider = context.read<GlobalProvider>();

    final textTheme = Theme.of(context).textTheme;
    final styleExtraInfo = textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w500,
    );
    return Consumer<ProductProvider>(
      builder: (_, product, __) {
        return Consumer(
          builder: (context, value, child) {
            final productSelected = product.selectProductState.product;
            final loadingState = product.selectProductState.isLoading;

            return loadingState
                ? simpleLoadingWithScaffold()
                : Scaffold(
                    appBar: AppBarWithBackIcon(
                      appBar: AppBar(),
                      title: productSelected!.name.toTitleCase(),
                      showTitle: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            context.push('/add_product',
                                extra: productSelected!.id);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            asyncShowConfirmDialog(
                              context,
                              'Eliminar',
                              '¿Estas seguro de eliminar este producto?',
                              () {
                                return productsProvider
                                    .deleteProductById(
                                  productSelected!.id,
                                  /* widget.productModel.images[0].src, */
                                )
                                    .then((value) {
                                  if (value) {
                                    globalProvider.showSnackBar(
                                      context,
                                      "Producto eliminado correctamente",
                                      backgroundColor: Colors.green,
                                    );
                                    context.pop();
                                  } else {
                                    globalProvider.showSnackBar(context,
                                        "No se pudo eliminar el producto");
                                  }
                                });
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        cardInventoryProvider.addProduct(productSelected);
                        context.push(
                          '/sell_products',
                        );
                      },
                      icon: const Icon(Icons.sell),
                      label: const Text(
                        'Vender Producto',
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Hero(
                    tag: widget.productModel.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.productModel.images.isNotEmpty
                            /* CHANGE THIS  */
                            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1EbnoClU2ybeReAasEBl-aSNItG0HU2aRqaYfsdL7&s'
                            /* ? widget.productModel.images[0].src */
                            : 'https://aeasa.com.mx/wp-content/uploads/2020/02/SIN-IMAGEN.jpg',
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), */
                            /* Change this */
                            /*  widget.productModel.images.isEmpty
                      ? const SizedBox()
                      : const SizedBox(
                          height: 250,
                          width: 600,
                          child: ImageGallery(
                            /* change this by the original */
                            images: [
                              'https://i.pinimg.com/originals/49/fb/12/49fb12b526930c3756494a67b899859d.jpg',
                              'https://i.ytimg.com/vi/V6UzcWt2wGg/maxresdefault.jpg'
                            ],
                          ),
                        ), */
                            SizedBox(
                              height: 250,
                              width: 600,
                              child: ImageGallery(
                                /* change this by the original */
                                images: productSelected.images
                                    .map((e) => e.src)
                                    .toList(),
                              ),
                            ),
                            Text(productSelected.name.toTitleCase(),
                                style: textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w700)),
                            /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleText(
                        text: widget.productModel.name.toTitleCase(),
                        fontSize: 22,
                        /* top: 10, */
                        fontWeight: FontWeight.w700,
                      ),
                      const Chip(
                        padding: EdgeInsets.all(0),
                        backgroundColor: Colors.deepPurple,
                        label:
                            Text('Cholita', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ), */
                            SimpleText(
                              text: productSelected.categories[0].name,
                              fontSize: 14,
                              top: 5,
                              bottom: 10,
                              lightThemeColor: Colors.grey,
                            ),
                            Text(
                              'Descripcion y detalles',
                              style: textTheme.titleSmall!.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              removeAllHtmlTags(
                                productSelected.description,
                              ).toCapitalize(),
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            /* textInfo(
                    'Plata 950',
                  ),
                  textInfo(
                    'Vino',
                  ), */
                            Wrap(
                              spacing: 6.0,
                              runSpacing: 6.0,
                              children: productSelected.tags
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        showMyDialogTagMaterial(
                                          context,
                                          e.id,
                                        );
                                      },
                                      child: Chip(
                                        label: Text(
                                          e.name.toCapitalize(),
                                          style: textTheme.bodySmall!.copyWith(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            /*  SimpleText(
                    text: 'Costo de creacion 150 Bs',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    top: 10,
                    bottom: 5,
                    lightThemeColor: Colors.black,
                  ), */
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                'Producto agregado el ${literalDateWithMount(productSelected.dateCreated!)}',
                                style: styleExtraInfo,
                              ),
                            ),

                            /* SimpleText(text: 'Vendido por: Virginia Arrieta', top: 5),
                  SimpleText(text: 'Vendido el 01 de diciembre de 2022', top: 10),
                  SimpleText(text: 'Precio final : 140', top: 10),
                  */
                            productSelected.manageStock
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Cantidad disponible: ${productSelected.stockQuantity}',
                                      style: styleExtraInfo,
                                    ),
                                  )
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text("${productSelected.price} Bs.",
                                  /* fontSize: 25,
                                fontWeight: FontWeight.w700,
                                top: 5,
                                bottom: 5,
                                lightThemeColor: Colors.black, */
                                  style: textTheme.titleSmall!.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.pink,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
