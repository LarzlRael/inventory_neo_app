part of '../widgets.dart';

class CardItemInventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'item_detail');
      },
      child: Card(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://m.media-amazon.com/images/I/41Vdpud95BS._SY500_.jpg',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  SimpleText(
                    text: 'Nombre del producto',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
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
