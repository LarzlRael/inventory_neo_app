part of '../pages.dart';

class MaterialAddEditPage extends StatefulWidget {
  final TagModel? materialTag;
  const MaterialAddEditPage({
    super.key,
    this.materialTag,
  });

  @override
  State<MaterialAddEditPage> createState() => _MaterialAddEditPageState();
}

class _MaterialAddEditPageState extends State<MaterialAddEditPage> {
  late CategoriesMaterialProviders categoriesMaterialProviders;
  late GlobalProvider globalProvider;
  @override
  void initState() {
    super.initState();
    categoriesMaterialProviders = context.read<CategoriesMaterialProviders>();
    globalProvider = context.read<GlobalProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          registerOrEdit(formKey, materialId: widget.materialTag?.id);
        },
        label: Text(
          widget.materialTag?.id == null
              ? 'Agregar material'
              : 'Editar material',
        ),
        icon: Icon(widget.materialTag?.id == null ? Icons.add : Icons.edit),
      ),
      appBar: AppBar(
        title: Text(
          widget.materialTag?.id == null
              ? 'Agregar material'
              : widget.materialTag!.name.toCapitalize(),
        ),
        actions: widget.materialTag?.id == null
            ? null
            : [
                IconButton(
                  onPressed: () {
                    asyncShowConfirmDialog(
                      context,
                      'Eliminar',
                      '¿Estás seguro de eliminar este material?',
                      () async {
                        categoriesMaterialProviders
                            .deleteMaterial(widget.materialTag!.id)
                            .then((value) {
                          if (value) {
                            globalProvider.showSnackBar(
                              context,
                              "Material eliminado correctamente",
                              backgroundColor: Colors.green,
                            );
                            context.pop();
                          } else {
                            globalProvider.showSnackBar(
                              context,
                              "Hubo un error",
                              backgroundColor: Colors.red,
                            );
                          }
                        });
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                FormBuilder(
                  initialValue: {
                    'id': widget.materialTag?.id,
                    'name': widget.materialTag?.name,
                    'description': widget.materialTag?.description
                  },
                  key: formKey,
                  onChanged: () {},
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,
                  child: Column(
                    children: [
                      CustomTextField(
                        name: 'name',
                        label: 'Nombre de material',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: "Este campo es requerido"),
                        ]),
                      ),
                      const CustomTextField(
                        label: 'Descripcion',
                        name: 'description',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  void registerOrEdit(
    GlobalKey<FormBuilderState> formkey, {
    int? materialId,
  }) async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    formkey.currentState!.save();

    final json = {
      "id": materialId,
      "name": formkey.currentState!.value['name'],
      "description": formkey.currentState!.value['description'],
    };
    categoriesMaterialProviders.addOrEditMaterial(json).then((value) {
      if (value) {
        globalProvider.showSnackBar(
          context,
          materialId != null
              ? 'Editado correctamente'
              : 'Agregado correctamente',
          backgroundColor: materialId != null ? Colors.blue : Colors.green,
        );
        context.pop();
      } else {
        globalProvider.showSnackBar(context, 'Hubo un error');
      }
    });
  }
}
