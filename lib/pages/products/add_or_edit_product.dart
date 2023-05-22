part of '../pages.dart';

class AddOrEditProduct extends StatefulWidget {
  const AddOrEditProduct({super.key, this.idProduct});
  final int? idProduct;

  @override
  State<AddOrEditProduct> createState() => _AddOrEditCategoriesState();
}

class _AddOrEditCategoriesState extends State<AddOrEditProduct> {
  /* final productsBloc = ProductsBloc(); */
  bool _isLoading = false;
  late ProductsProvider productsProvider;
  late ProductProvider productProvider;
  late CategoriesMaterialProviders categoriesMaterialProviders;
  @override
  void initState() {
    super.initState();
    productsProvider = context.read<ProductsProvider>();
    productProvider = context.read<ProductProvider>();
    categoriesMaterialProviders = context.read<CategoriesMaterialProviders>();
    productProvider.loadProduct(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Consumer<ProductProvider>(
      builder: (context, product, child) {
        final selectProductState = productProvider.selectProductState.product;
        final loadingState = productProvider.selectProductState.isLoading;
        return Scaffold(
          appBar: AppBarWithBackIcon(
            appBar: AppBar(),
            actions: widget.idProduct != null
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
            title: selectProductState?.idProduct == null
                ? 'Agregar producto'
                : 'Editar producto',
            showTitle: true,
          ),
          body: SingleChildScrollView(
            child: loadingState
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        selectProductState!.images.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: 250,
                                width: 600,
                                child: ImageGallery(
                                  /* change this by the original */
                                  images: [
                                    'https://i.pinimg.com/originals/49/fb/12/49fb12b526930c3756494a67b899859d.jpg',
                                    'https://i.ytimg.com/vi/V6UzcWt2wGg/maxresdefault.jpg'
                                  ],
                                ),
                              ),
                        const SizedBox(height: 10),
                        FormBuilder(
                          enabled: !_isLoading,
                          key: formKey,
                          initialValue: {
                            'name': selectProductState!.name,
                            'regular_price': selectProductState.price,
                            'description': selectProductState.description,
                            'category': selectProductState.category,
                            'tags': selectProductState.idTags,
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
                                categories: categoriesMaterialProviders
                                    .categoriesState.categoriesList,
                              ),
                              CustomRadioButtons(
                                formFieldName: 'tags',
                                placeholder: 'Seleccione una categoria',
                                title: 'Materiales',
                                options: selectProductState.idTags,
                                materiales: categoriesMaterialProviders
                                    .materialesState.materiales,
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
                                  register(formKey,
                                      idProduct: selectProductState.idProduct);
                                },
                                label: selectProductState.idProduct == null
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
      },
    );
  }

  Future<String> getUrlFileResult(String path) async {
    final uploadFile = await Request.uploadFileRequest(
      RequestType.post,
      '/uploadFiles',
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
