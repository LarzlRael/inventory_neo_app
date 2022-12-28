part of '../pages.dart';

class ItemDetails {
  int? idProduct;
  String name;
  String price;
  String description;
  int category;
  List<String> idTags;
  ItemDetails({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.idTags,
    this.idProduct,
  });
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddProduct>
    with AutomaticKeepAliveClientMixin {
  final productsBloc = ProductsBloc();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final itemDetails = ItemDetails(
      idProduct: null,
      name: '',
      price: '',
      description: '',
      category: 0,
      idTags: [],
    );
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ItemDetails?;
    if (arguments != null) {
      itemDetails.idProduct = arguments.idProduct;
      itemDetails.name = arguments.name;
      itemDetails.price = arguments.price;
      itemDetails.description = arguments.description;
      itemDetails.category = arguments.category;
      itemDetails.idTags = arguments.idTags;
    }
    super.build(context);
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: itemDetails.idProduct == null
            ? 'Agregar producto'
            : 'Editar producto',
        showTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              FormBuilder(
                /* enabled: !_isLoading, */
                key: formKey,
                initialValue: {
                  'name': itemDetails.name,
                  'regular_price': itemDetails.price,
                  'description': itemDetails.description,
                  'category': itemDetails.category,
                  'tags': itemDetails.idTags,
                  /* 'file': itemDetails.file, */
                },
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
                      options: itemDetails.idTags,
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
                        register(formKey, idProduct: itemDetails.idProduct);
                      },
                      label: itemDetails.idProduct == null
                          ? 'Registrar'
                          : 'Editar',
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
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

  void register(GlobalKey<FormBuilderState> formkey, {int? idProduct}) async {
    formkey.currentState!.save();

    bool isFile = formkey.currentState!.value['file'] != null;
    final productoService = ProductsServices();

    final json = {
      "name": formkey.currentState!.value['name'],
      "manage_stock": true,
      "stock_quantity": 1,
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
    if (isFile && formkey.currentState!.value['file'].length > 0) {
      json.addAll(
        {
          "image": [
            {
              "src": await getUrlFileResult(
                  formkey.currentState!.value['file'][0].path)
            }
          ]
        },
      );
    }
    setState(() {
      _isLoading = true;
    });

    final correct = await productoService.createOrUpdateProduct(
      json,
      edit: idProduct != null,
      idProduct: idProduct,
    );

    if (!mounted) return;
    if (correct) {
      GlobalSnackBar.show(
        context,
        'Registro exitoso',
        backgroundColor: Colors.green,
      );
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }

      Navigator.pushNamed(context, 'list_products_page');
      productsBloc.getProducts();
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
