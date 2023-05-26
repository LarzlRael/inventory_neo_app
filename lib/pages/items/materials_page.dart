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
    categoriesMaterialProviders.getFetchMaterialTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Agregar material'),
        onPressed: () {
          context.push('/material_add_edit_page');
        },
        icon: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Materiales',
        subTitle: 'Lista de los materiales',
        showTitle: true,
      ),
      body: Consumer<CategoriesMaterialProviders>(
        builder: (context, state, widget) {
          final materials = state.materialesState;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView.builder(
              itemCount: materials.materiales.length,
              itemBuilder: (_, int index) {
                return MaterialItemCard(
                  tag: materials.materiales[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
