part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  final ProductsModel productModel;
  const CardItemInventory({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider = context.watch<CardInventoryProvider>();
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
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: ClipRRect(
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
          title: SimpleText(
            text: productModel.name.toCapitalize(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            bottom: 5,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: productModel.categories[0].name.toCapitalize(),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                lightThemeColor: Colors.grey,
                bottom: 5,
              ),
              SimpleText(
                top: 5,
                text: productModel.price,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: () {
              cardInventoryProvider.deleteProduct(productModel);
            },
          ),
        ),
      ),
    );
  }
}
