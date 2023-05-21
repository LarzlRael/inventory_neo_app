part of '../pages.dart';

class ItemDetailPage extends StatefulWidget {
  final ProductsModel productModel;
  const ItemDetailPage({
    super.key,
    required this.productModel,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider = context.read<CardInventoryProvider>();
    final productsProvider = context.read<ProductsProvider>();
    final globalProvider = context.read<GlobalProvider>();
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: widget.productModel.name.toTitleCase(),
        showTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.push('/add_product', extra: widget.productModel.id);
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
                    widget.productModel.id.toString(),
                    /* widget.productModel.images[0].src, */
                  )
                      .then((value) {
                    if (value) {
                      globalProvider.showSnackBar(
                        context,
                        "Producto eliminado correctamente",
                        backgroundColor: Colors.green,
                      );
                      /* productBloc.getProducts(); */
                      Navigator.pop(context);
                    } else {
                      globalProvider.showSnackBar(
                          context, "No se pudo eliminar el producto");
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
              const SizedBox(
                height: 250,
                width: 600,
                child: ImageGallery(
                  /* change this by the original */
                  images: [
                    'https://i.pinimg.com/originals/49/fb/12/49fb12b526930c3756494a67b899859d.jpg',
                    'https://i.ytimg.com/vi/V6UzcWt2wGg/maxresdefault.jpg'
                  ],
                ),
              ),
              Text(widget.productModel.name.toTitleCase(),
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
                text: widget.productModel.categories[0].name,
                fontSize: 14,
                top: 5,
                bottom: 10,
                lightThemeColor: Colors.grey,
              ),
              const SimpleText(
                text: 'Descripcion y detalles',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                top: 5,
                bottom: 5,
                lightThemeColor: Colors.black,
              ),
              SimpleText(
                text: removeAllHtmlTags(widget.productModel.description),
                fontSize: 14,
                top: 5,
                bottom: 10,
                lightThemeColor: Colors.grey,
              ),
              /* textInfo(
                'Plata 950',
              ),
              textInfo(
                'Vino',
              ), */
              Column(
                children: widget.productModel.tags
                    .map((e) => textInfo(e.name, tagId: e.id.toString()))
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

              Row(
                children: [
                  SimpleText(
                    text: widget.productModel.price,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    top: 5,
                    bottom: 5,
                    lightThemeColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Expanded(
                    child: FillButton(
                      label: 'Vender Producto',
                      fontWeight: FontWeight.w500,
                      labelButtonFontSize: 14,
                      backgroundColor: Colors.orange,
                      borderRadius: 10,
                      onPressed: () {
                        cardInventoryProvider.addProduct(widget.productModel);
                        context.go(
                          '/sell_products',
                        );
                      },
                    ),
                  ),
                  /* Expanded(
                    child: FillButton(
                      label: 'Vender',
                      fontWeight: FontWeight.w500,
                      labelButtonFontSize: 14,
                      backgroundColor: Colors.black,
                      borderRadius: 10,
                      onPressed: () {},
                    ),
                  ), */
                ],
              ),
              /* SimpleText(text: 'Vendido por: Virginia Arrieta', top: 5),
              SimpleText(text: 'Vendido el 01 de diciembre de 2022', top: 10),
              SimpleText(text: 'Precio final : 140', top: 10),
              */

              widget.productModel.manageStock
                  ? SimpleText(
                      text:
                          'Cantidad disponible: ${widget.productModel.stockQuantity}',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      top: 10,
                    )
                  : SimpleText(
                      text:
                          'Producto agregado el ${literalDateWithMount(widget.productModel.dateCreated!)}',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      top: 10,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textInfo(String info, {String tagId = ''}) {
    /* list with bullet*/
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        onTap: () {
          showMyDialogTagMaterial(
            context,
            tagId,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          /* mainAxisAlignment: MainAxisAlignment.center, */
          children: [
            const Icon(
              Icons.circle,
              size: 10,
              color: Colors.black,
            ),
            const SizedBox(
              width: 5,
            ),
            SimpleText(
              text: info,
              fontSize: 14,
              lightThemeColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
