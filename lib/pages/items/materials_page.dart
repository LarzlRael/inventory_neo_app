part of '../pages.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  late CategoriesMaterialProviders categoriesMaterialProviders;

  @override
  initState() {
    super.initState();
    categoriesMaterialProviders = context.read<CategoriesMaterialProviders>();
    categoriesMaterialProviders.getFetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final materials = categoriesMaterialProviders.materialesState;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar material',
        onPressed: () {
          context.push('/material_register_page');
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
            Expanded(
              child: ListView.builder(
                itemCount: materials.materiales.length,
                itemBuilder: (_, int index) {
                  final tag = materials.materiales[index];
                  return MaterialItemCard(tag: tag);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
