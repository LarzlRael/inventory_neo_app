part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  const CardItemInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* Navigator.pushNamed(context, 'item_detail'); */
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ItemDetailPage(),
            duration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://i.pinimg.com/originals/49/6f/bf/496fbfb4cd35c4a14e8cff20fdac2faa.jpg',
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
                        text: 'Arete',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        lightThemeColor: Colors.grey,
                        bottom: 5,
                      ),
                      SimpleText(
                        text: 'Nombre del producto',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      SimpleText(
                        top: 5,
                        text: '200',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  SizedBox(
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
