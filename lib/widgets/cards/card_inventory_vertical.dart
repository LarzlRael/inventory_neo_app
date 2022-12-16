part of '../widgets.dart';

class CardItemInventoryVertical extends StatelessWidget {
  final ProductsModel productModel;
  const CardItemInventoryVertical({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ItemDetailPage(productModel: productModel),
            duration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
        /* height: MediaQuery.of(context).size.width * 0.9, */

        child: Card(
          elevation: 0,
          /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  productModel.images.isNotEmpty
                      ? productModel.images[0].src
                      : 'https://aeasa.com.mx/wp-content/uploads/2020/02/SIN-IMAGEN.jpg',
                  height: 150,
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
                        bottom: 2,
                        top: 2,
                        text: productModel.price,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        lightThemeColor: Colors.pink,
                      ),
                      SimpleText(
                        text: productModel.name,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ],
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
