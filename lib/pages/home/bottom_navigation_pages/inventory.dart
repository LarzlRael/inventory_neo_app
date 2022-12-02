part of '../../pages.dart';

class Inventory extends StatelessWidget {
  final pageViewController = PageController();
  final cardArray = const [
    CategoryCard(
      title: 'Anillos',
      urlImage:
          'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
      color: Colors.blue,
    ),
    CategoryCard(
      title: 'Aretes',
      urlImage:
          'https://cdn.shopify.com/s/files/1/0039/6643/5377/products/ES013copy_600x.png?v=1663068249',
      color: Colors.cyan,
    ),
    CategoryCard(
      title: 'Dijes',
      urlImage:
          'https://glauser.vteximg.com.br/arquivos/ids/159291-268-268/DVITDW1210LDBP1B1.png?v=637447716808730000',
      color: Colors.red,
    ),
    CategoryCard(
      title: 'Collares',
      urlImage:
          'https://i.pinimg.com/originals/6b/af/fc/6baffc223f85c454aa61008a4dfd1324.png',
      color: Colors.red,
    ),
    CategoryCard(
      title: 'Conjuntos',
      urlImage:
          'https://www.joyeriasanchez.com/29298-home_default/conjunto-valley-oro-18k.jpg',
      color: Colors.deepPurple,
    ),
    CategoryCard(
      title: 'Manillas',
      urlImage:
          'https://www.joyeriasanchez.com/53325-home_default/pulsera-carla-oro-bicolor-18k.jpg',
      color: Colors.cyanAccent,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              top: 50,
              text: 'Busca tu ',
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            SimpleText(
              text: 'Joya',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            searchBar(context),
            SimpleText(
              top: 10,
              bottom: 10,
              text: 'Escoge \nuna categoria',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Container(
              height: 125,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardArray.length,
                itemBuilder: (BuildContext context, int index) {
                  return cardArray[index];
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: ItemsInventoryDelegate(),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
          top: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SimpleText(text: 'Buscar un producto...'),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String urlImage;
  final Color color;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.urlImage,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'list_items_category');
      },
      child: Container(
        width: 125,
        height: 125,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          /* hex color */
          /* color: const Color(0xffff7648), */
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 125,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color,
                    ),
                  ),
                ),
                Positioned(
                  child: SimpleText(
                    top: 10,
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    lightThemeColor: Colors.white,
                  ),
                  bottom: 10,
                  left: 10,
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -5,
              child: Image.network(
                urlImage,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCategoryItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        title: 'Anillos',
        appBar: AppBar(),
      ),
      body: Column(
        children: [
          CategoryCard(
            title: 'Anillos',
            urlImage:
                'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
            color: Colors.blue,
          ),
          Expanded(
            child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              /* padding: const EdgeInsets.all(10), */
              /* childAspectRatio: 3 / 2, */
              crossAxisCount: 2,
              children: const [
                CardItemInventoryVertical(),
                CardItemInventoryVertical(),
                CardItemInventoryVertical(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
