part of '../../pages.dart';

class Inventory extends StatelessWidget {
  final pageViewController = PageController();
  /* final cardArray = const [
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
  ]; */
  @override
  Widget build(BuildContext context) {
    final categoriesServices = CategoriesServices();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SimpleText(
              top: 50,
              text: 'Busca tu ',
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            const SimpleText(
              text: 'Joya',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            searchBar(context),
            const SimpleText(
              top: 10,
              bottom: 10,
              text: 'Escoge \nuna categoria',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            FutureBuilder(
              future: categoriesServices.getCategories(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CategoriesModel>> snapshot) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }

                /* return ListView.builder(
                    /* scrollDirection: Axis.horizontal, */
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                        id: snapshot.data![index].id.toString(),
                        title: snapshot.data![index].name,
                        urlImage:
                            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
                        color: Colors.blue,
                      );
                    },
                  ); */
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      /* childAspectRatio: 3 / 2, */
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return CategoryCard(
                        id: snapshot.data![index].id.toString(),
                        title: snapshot.data![index].name,
                        urlImage:
                            'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
                        color: Colors.blue,
                      );
                    },
                  ),
                );
              },
            ),
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
  final String id;
  const CategoryCard({
    Key? key,
    required this.title,
    required this.urlImage,
    required this.color,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, 'list_items_category', arguments: id);
      },
      child: Container(
        width: 125,
        height: 125,
        margin: const EdgeInsets.only(right: 10),
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: color,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: SimpleText(
                    top: 10,
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    lightThemeColor: Colors.white,
                  ),
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
  const ListCategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as String;
    final productsServices = ProductsServices();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        title: 'Productos',
        appBar: AppBar(),
        showTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemsInventoryDelegate(),
              );
            },
            color: Colors.black,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          /*  CategoryCard(
            title: 'Anillos',
            urlImage:
                'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
            color: Colors.blue,
          ), */
          FutureBuilder(
            future: productsServices.getProductsByCategory(arguments),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductsModel>> snapshot) {
              if (!snapshot.hasData) {
                return simpleLoading();
              }
              if (snapshot.data!.isEmpty) {
                return const Expanded(
                  child: NoInformation(
                    text: 'No hay productos en esta categoria',
                    icon: Icons.info_outline,
                    showButton: false,
                    iconButton: Icons.add,
                  ),
                );
              }

              return Expanded(
                child: GridView.count(
                    /* shrinkWrap: true, */
                    /* physics: NeverScrollableScrollPhysics(), */
                    /* padding: const EdgeInsets.all(10), */
                    /* childAspectRatio: 3 / 2, */
                    crossAxisCount: 2,
                    children: snapshot.data!.map<Widget>(
                      (product) {
                        return CardItemInventoryVertical(
                          productModel: product,
                        );
                      },
                    ).toList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
