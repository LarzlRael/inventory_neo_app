part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  final ProductsModel productModel;
  const CardItemInventory({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        /* Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ItemDetailPage(),
            duration: const Duration(milliseconds: 400),
          ),
        ); */
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      SimpleText(
                        text: productModel.name,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
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
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
