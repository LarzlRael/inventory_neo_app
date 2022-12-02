part of '../widgets.dart';

class CardItemInventoryVertical extends StatelessWidget {
  const CardItemInventoryVertical({super.key});

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
      child: Container(
        margin: EdgeInsets.only(bottom: 0, left: 5, right: 5),
        /* height: MediaQuery.of(context).size.width * 0.9, */
        /*  */

        child: Card(
          elevation: 0,
          /* margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), */
          child: Flexible(
            /* padding: EdgeInsets.all(10), */

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    'https://www.brides.com/thmb/F8B0OXob-vFc8iUDZgjDlt87h4U=/fit-in/1500x640/filters:no_upscale():max_bytes(150000):strip_icc()/ScreenShot2021-07-25at10.21.05JPEG-237dc7b21897494280347b163ebd6a81.jpg',
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
                          text: '200BS',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          lightThemeColor: Colors.pink,
                        ),
                        SimpleText(
                          text: 'Nombre del producto',
                          fontSize: 14,
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
      ),
    );
  }
}
