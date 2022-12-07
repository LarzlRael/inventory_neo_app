part of '../pages.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesServices = CategoriesServices();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'add_category_page');
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
              Expanded(
                child: FutureBuilder(
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
                    return GridView.builder(
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
                        });
                  },
                ),
              )
            ],
          )),
    );
  }
}
