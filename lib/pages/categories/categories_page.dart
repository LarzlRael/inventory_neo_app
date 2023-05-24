part of '../pages.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late CategoriesMaterialProviders categoriesMaterialProviders;
  @override
  void initState() {
    super.initState();
    categoriesMaterialProviders = context.read<CategoriesMaterialProviders>();
    categoriesMaterialProviders.getFetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Agregar categoria'),
        icon: const Icon(Icons.add),
        onPressed: () {
          context.push('/add_categories_page');
        },
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Categorias',
        subTitle: 'Lista de las categorias',
        showTitle: true,
      ),
      body: Consumer<CategoriesMaterialProviders>(
        builder: (_, categoriesMaterialProviders, child) {
          final categoriesList =
              categoriesMaterialProviders.categoriesState.categoriesList;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 35,
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  categoriesModel: categoriesList[index],
                  goToProductsByCategory: true,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
