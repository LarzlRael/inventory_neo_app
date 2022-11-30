part of '../pages.dart';

class ItemDetailPage extends StatefulWidget {
  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        /* title: 'Iniciar sesión', */
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://m.media-amazon.com/images/I/41Vdpud95BS._SY500_.jpg',
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SimpleText(
                    text: 'Arete Gota de vino',
                    fontSize: 22,
                    /* top: 10, */
                    fontWeight: FontWeight.w700,
                  ),
                  Chip(
                    padding: EdgeInsets.all(0),
                    backgroundColor: Colors.deepPurple,
                    label:
                        Text('Cholita', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SimpleText(
                text: 'Aretes',
                fontSize: 14,
                top: 5,
                bottom: 10,
                lightThemeColor: Colors.grey,
              ),
              SimpleText(
                text: 'Descripcion y detalles',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                top: 5,
                bottom: 5,
                lightThemeColor: Colors.black,
              ),
              SimpleText(
                text:
                    'Cupidatat minim incididunt aute velit et irure culpa consequat nisi esse ad dolore minim labore. Lorem ex adipisicing veniam laboris dolore..',
                fontSize: 14,
                top: 5,
                bottom: 10,
                lightThemeColor: Colors.grey,
              ),
              textInfo(
                'Plata 950',
              ),
              textInfo(
                'Vino',
              ),
              SimpleText(
                text: 'Costo de creacion 150 Bs',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                top: 10,
                bottom: 5,
                lightThemeColor: Colors.black,
              ),
              Row(
                children: [
                  SimpleText(
                    text: '200 Bs',
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    top: 5,
                    bottom: 5,
                    lightThemeColor: Colors.black,
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Expanded(
                    child: FillButton(
                      label: 'Vender',
                      fontWeight: FontWeight.w500,
                      labelButtonFontSize: 14,
                      backgroundColor: Colors.black,
                      borderRadius: 10,
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textInfo(String info) {
    /* list with bullet*/
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        onTap: () {
          showMyDialog(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          /* mainAxisAlignment: MainAxisAlignment.center, */
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: Colors.black,
            ),
            SizedBox(
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
