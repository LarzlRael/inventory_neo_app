part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  final ProductModel productModel;
  final void Function(ProductModel productModel)? onSelected;
  const CardItemInventory({
    super.key,
    required this.productModel,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider = context.watch<CardInventoryProvider>();
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        if (onSelected != null) {
          onSelected!(productModel);
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              productModel.images.isEmpty
                  ? 'https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg'
                  : productModel.images[0].src,
              height: 75,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          title: SimpleText(
            text: productModel.name.toCapitalize(),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            padding: const EdgeInsets.only(bottom: 5),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: productModel.categories[0].name.toCapitalize(),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                padding: const EdgeInsets.only(top: 10, bottom: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  productModel.price,
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.pink,
                  ),
                ),
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
