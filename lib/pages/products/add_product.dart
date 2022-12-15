part of '../pages.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Agregar producto',
        showTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
              /* enabled: !_isLoading, */
              key: formKey,
              // enabled: false,
              onChanged: () {
                /*  _formKey.currentState!.save();
                debugPrint(_formKey.currentState!.value.toString()); */
              },
              autovalidateMode: AutovalidateMode.disabled,

              skipDisabled: true,
              child: Column(
                children: const [
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
                  CustomFileField(
                    name: 'file',
                  ),
                ],
              ),
            ),
            !_isLoading
                ? FillButton(
                    onPressed: () {
                      register(formKey);
                    },
                    label: 'Registrar',
                  )
                : Center(child: const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Future<String> getUrlFileResult(String path) async {
    final uploadFile = await Request.uploadFileRequest(
      RequestType.post,
      'upload',
      {},
      File(
        path,
      ),
      '',
      useAuxiliarUrl: true,
    );

    return jsonDecode(uploadFile.body)['secure_url'];
  }

  void register(GlobalKey<FormBuilderState> formkey) async {
    formkey.currentState!.save();
    final productoService = ProductsServices();

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
      "images": [
        {
          "src": await getUrlFileResult(
              formkey.currentState!.value['file'][0].path),
        }
      ],
      "tags": formkey.currentState!.value['tags']
          .map((e) => {
                "id": e,
              })
          .toList()
    };
    debugPrint(json.toString());
    setState(() {
      _isLoading = true;
    });
    final correct = await productoService.createProduct(json);

    if (!mounted) return;
    if (correct) {
      GlobalSnackBar.show(
        context,
        'Registro exitoso',
        backgroundColor: Colors.green,
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, 'list_products_page');
    } else {
      setState(() {
        _isLoading = false;
      });
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
