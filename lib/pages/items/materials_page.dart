part of '../pages.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    /* final tagsServices = TagsServices(); */
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar material',
        onPressed: () {
          Navigator.pushNamed(context, 'material_register_page');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Materiales',
        subTitle: 'Lista de los materiales',
        showTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            FutureBuilder(
              future: getAllTags(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TagsModel>> snapshot) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, int index) {
                      final tag = snapshot.data![index];
                      return MaterialItemCard(tag: tag);
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

  Future<List<TagsModel>> getAllTags() async {
    final clientRequest = await getAction('products/tags');
    return tagsModelFromJson(clientRequest!.body);
  }
}
