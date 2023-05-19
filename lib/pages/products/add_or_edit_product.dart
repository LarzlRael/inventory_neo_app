part of '../pages.dart';

class ItemDetails {
  int? idProduct;
  String name;
  String price;
  String description;
  int category;
  List<String> idTags;
  List<String> images = [];
  ItemDetails({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.idTags,
    required this.images,
    this.idProduct,
  });
}

class AddOrEditProduct extends StatefulWidget {
  const AddOrEditProduct({super.key, this.itemDetails});
  final ItemDetails? itemDetails;

  @override
  State<AddOrEditProduct> createState() => _AddOrEditCategoriesState();
}

class _AddOrEditCategoriesState extends State<AddOrEditProduct> {
  /* final productsBloc = ProductsBloc(); */
  bool _isLoading = false;
  late ProductsProvider productsProvider;
  late ProductProvider productProvider;
  @override
  void initState() {
    productsProvider = context.read<ProductsProvider>();
    productProvider = context.read<ProductProvider>();
    /* productsProvider.loadProducts(); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesMaterialProviders =
        context.read<CategoriesMaterialProviders>();
    final itemDetails = ItemDetails(
      idProduct: null,
      name: '',
      price: '',
      description: '',
      category: 15,
      idTags: [],
      images: [],
    );

    if (widget.itemDetails != null) {
      itemDetails.idProduct = widget.itemDetails?.idProduct;
      itemDetails.name = widget.itemDetails!.name;
      itemDetails.price = widget.itemDetails!.price;
      itemDetails.description = widget.itemDetails!.description;
      itemDetails.category = widget.itemDetails!.category;
      itemDetails.idTags = widget.itemDetails!.idTags;
      itemDetails.images = widget.itemDetails!.images;
    }
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        actions: itemDetails.idProduct != null
            ? [
                IconButton(
                  onPressed: () async {
                    await CamerGalleryServiceImp().takePhoto();
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: () async {
                    await CamerGalleryServiceImp().selectFromGallery();
                  },
                  icon: const Icon(Icons.photo_album),
                ),
              ]
            : null,
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
              itemDetails.images.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      height: 250,
                      width: 600,
                      child: ImageGallery(
                        /* change this by the original */
                        images: itemDetails.images,
                      ),
                    ),
              const SizedBox(height: 10),
              FormBuilder(
                enabled: !_isLoading,
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
                      keyboardType: TextInputType.text,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Este campo es requerido"),
                        FormBuilderValidators.minLength(3),
                      ]),
                    ),
                    CustomTextField(
                      label: 'Precio',
                      name: 'regular_price',
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Este campo es requerido"),
                        FormBuilderValidators.numeric(),
                      ]),
                    ),
                    const CustomTextField(
                      label: 'Descripcion',
                      name: 'description',
                    ),
                    CustomFormBuilderFetchDropdown(
                      title: 'Categoria',
                      formFieldName: 'category',
                      placeholder: 'Seleccione una categoria',
                      categories: categoriesMaterialProviders.getCategories,
                    ),
                    CustomRadioButtons(
                      formFieldName: 'tags',
                      placeholder: 'Seleccione una categoria',
                      title: 'Materiales',
                      options: itemDetails.idTags,
                      materiales: categoriesMaterialProviders.getMateriales,
                    ),
                    /* const CustomFileField(
                      name: 'file',
                    ), */
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
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getUrlFileResult(String path) async {
    final uploadFile = await Request.uploadFileRequest(
      RequestType.post,
      'api/uploadFiles',
      {},
      File(path),
      useAuxiliarUrl: true,
    );

    return jsonDecode(uploadFile.body)['secure_url'];
  }

  void register(GlobalKey<FormBuilderState> formkey, {int? idProduct}) async {
    final globalProvider = context.read<GlobalProvider>();

    if (!formkey.currentState!.validate()) {
      return;
    }
    formkey.currentState!.save();

    bool isFile = formkey.currentState!.value['file'] != null;

    setState(() {
      _isLoading = true;
    });
    final Map<String, dynamic> json = {
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
          "images": [
            {
              "src": await getUrlFileResult(
                  formkey.currentState!.value['file'][0].path)
            }
          ]
        },
      );
    }
    productsProvider
        .createOrUpdateProduct(
      json,
      idProduct: idProduct,
    )
        .then((value) {
      globalProvider.showSnackBar(
        context,
        'Registro exitoso',
        backgroundColor: Colors.green,
      );

      setState(() {
        _isLoading = false;
      });
      context.pop();
    }).catchError((error) {
      globalProvider.showSnackBar(
        context,
        'Error al registrar',
        backgroundColor: Colors.red,
      );
      setState(() {
        _isLoading = false;
      });
    });
  }
}
