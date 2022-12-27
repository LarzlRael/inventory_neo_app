part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  final ProductsModel productModel;
  const CardItemInventory({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider =
        Provider.of<CardInventoryProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ItemDetailPage(
              productModel: productModel,
            ),
            duration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  productModel.images.isNotEmpty
                      ? productModel.images[0].src
                      : 'https://aeasa.com.mx/wp-content/uploads/2020/02/SIN-IMAGEN.jpg',
                  height: 75,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Column(
                    /* mainAxisAlignment: MainAxisAlignment.start, */
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SimpleText(
                        text: productModel.categories[0].name,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        lightThemeColor: Colors.grey,
                        bottom: 5,
                      ),
                      Container(
                        width: 170,
                        child: SimpleText(
                          text: productModel.name.toCapitalize(),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          bottom: 5,
                        ),
                      ),
                      SimpleText(
                        top: 5,
                        text: productModel.price,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Eliminar producto',
                onPressed: () {
                  cardInventoryProvider.deleteProduct(productModel);
                },
                icon: const Icon(
                  Icons.cancel_sharp,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
