part of '../widgets.dart';

class CardItemInventoryVertical extends StatelessWidget {
  final ProductModel productModel;
  const CardItemInventoryVertical({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        /* Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ItemDetailPage(productModel: productModel),
            duration: const Duration(milliseconds: 400),
          ),
        ); */
        context.push('/item_detail', extra: productModel);
      },
      child: Hero(
        tag: productModel.id,
        child: Container(
          margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
          /* height: 300, */
          child: Card(
            elevation: 0,
            /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    productModel.images.isEmpty
                        ?
                        /* Change this */
                        'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930'
                        : productModel.images[0].src,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        /* mainAxisAlignment: MainAxisAlignment.start, */
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              productModel.price,
                              style: textTheme.titleSmall!.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.pink,
                              ),
                            ),
                          ),
                          Text(
                              productModel.name.length > 60
                                  ? '${productModel.name.substring(0, 60).toCapitalize()}...'
                                  : productModel.name.toCapitalize(),
                              style:
                                  GoogleFonts.montserratAlternates().copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
