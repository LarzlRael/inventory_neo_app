part of '../pages.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = CategoriesBloc();
    categoriesBloc.getCategories();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'add_categories_page');
        },
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Categorias',
        subTitle: 'Lista de las categorias',
        showTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            StreamBuilder(
              stream: categoriesBloc.categoriesStream,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<CategoriesModel>> snapshot,
              ) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }

                return Flexible(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (_, index) {
                      final category = snapshot.data![index];
                      return CategoryCard(
                        categoriesModel: category,
                        goToProductsByCategory: true,
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

  Future<List<CategoriesModel>> getCategories() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'products/categories',
      {},
      'xd',
    );
    return categoriesModelFromJson(clientRequest!.body);
  }
}
