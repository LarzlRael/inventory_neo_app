part of '../../pages.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory>
    with AutomaticKeepAliveClientMixin {
  final pageViewController = PageController();
  final List<CategoriesModel> category = [];
  @override
  initState() {
    super.initState();
    CategoriesServices().getCategories().then((value) {
      setState(() {
        category.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  /* childAspectRatio: 3 / 2, */
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: category.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CategoryCard(
                    categoriesModel: category[index],
                  );
                },
              ),
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

  @override
  bool get wantKeepAlive => true;
}

class CategoryCard extends StatelessWidget {
  final CategoriesModel categoriesModel;
  final bool goToProductsByCategory;
  const CategoryCard({
    Key? key,
    required this.categoriesModel,
    this.goToProductsByCategory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (goToProductsByCategory) {
          Navigator.pushNamed(
            context,
            'add_categories_page',
            arguments: CategoryForm(
              id: categoriesModel.id,
              name: categoriesModel.name,
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            'list_items_category',
            arguments: categoriesModel.id,
          );
        }
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
                      color: Colors.blue,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: SimpleText(
                    top: 10,
                    text: categoriesModel.name,
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
                categoriesModel.image == null
                    ? 'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png'
                    : categoriesModel.image!.src,
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
    final arguments = ModalRoute.of(context)!.settings.arguments as int;
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
