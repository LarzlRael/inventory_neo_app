part of '../pages.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Agregar producto',
        showTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                // enabled: false,
                onChanged: () {
                  /*  _formKey.currentState!.save();
                  debugPrint(_formKey.currentState!.value.toString()); */
                },
                autovalidateMode: AutovalidateMode.disabled,

                skipDisabled: true,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Nombre del producto',
                      name: 'name',
                    ),
                    CustomTextField(
                      label: 'Precio',
                      name: 'regular_price',
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextField(
                      label: 'Descripcion',
                      name: 'description',
                    ),
                    CustomFormBuilderFetchDropdown(
                      title: 'Categoria',
                      formFieldName: 'category',
                      placeholder: 'Seleccione una categoria',
                    ),
                    CustomRadioButtons(
                      formFieldName: 'tags',
                      placeholder: 'Seleccione una categoria',
                      title: 'Materiales',
                    ),
                  ],
                ),
              ),
              FillButton(
                onPressed: () {
                  register(_formKey);
                },
                label: 'Registrar',
              )
            ],
          ),
        ),
      ),
    );
  }

  void register(GlobalKey<FormBuilderState> formkey) async {
    formkey.currentState!.save();
    final productoService = ProductsServices();
    print(formkey.currentState!.value);
    print(formkey.currentState!.value['category']);

    final json = {
      "name": formkey.currentState!.value['name'],
      "type": "simple",
      "regular_price": formkey.currentState!.value['regular_price'],
      "description": formkey.currentState!.value['description'],
      "categories": [
        {
          "id": formkey.currentState!.value['category'],
        },
      ],
      "tags": formkey.currentState!.value['tags']
          .map((e) => {
                "id": e,
              })
          .toList()
    };
    debugPrint(json.toString());
    final correct = await productoService.createProduct(json);

    if (!mounted) return;
    if (correct) {
      GlobalSnackBar.show(
        context,
        'Registro exitoso',
        backgroundColor: Colors.green,
      );
      Navigator.pushReplacementNamed(context, 'list_products_page');
    } else {
      GlobalSnackBar.show(
        context,
        'Error al registrar',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
