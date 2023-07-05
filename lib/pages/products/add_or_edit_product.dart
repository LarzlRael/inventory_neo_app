part of '../pages.dart';

class AddOrEditProduct extends StatefulWidget {
  const AddOrEditProduct({super.key, this.idProduct});
  final int? idProduct;

  @override
  State<AddOrEditProduct> createState() => _AddOrEditCategoriesState();
}

class _AddOrEditCategoriesState extends State<AddOrEditProduct> {
  late ProductsProvider productsProvider;
  late ProductProvider productProvider;
  late CategoriesMaterialProviders categoriesMaterialProviders;
  late GlobalProvider globalProvider;
  @override
  void initState() {
    super.initState();
    productsProvider = context.read<ProductsProvider>();
    productProvider = context.read<ProductProvider>();
    globalProvider = context.read<GlobalProvider>();
    categoriesMaterialProviders = context.read<CategoriesMaterialProviders>();
    productProvider.loadProduct(widget.idProduct);
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Consumer<ProductProvider>(
      builder: (context, product, child) {
        final selectProductState =
            productProvider.selectProductState.selectedProduct;
        final loadingState = productProvider.selectProductState.isLoading;
        final isSaving = productProvider.selectProductState.isSaving;
        if (loadingState) {
          return simpleLoadingWithScaffold();
        }
        return Scaffold(
          appBar: AppBarWithBackIcon(
            appBar: AppBar(),
            actions: widget.idProduct != null
                ? [
                    IconButton(
                      onPressed: () async {
                        final photoPath =
                            await CamerGalleryServiceImp().selectFromGallery();
                        if (photoPath == null) return;
                        productProvider.updateProductImage(photoPath);
                      },
                      icon: const Icon(Icons.photo_album),
                    ),
                    IconButton(
                      onPressed: () async {
                        final photoPath =
                            await CamerGalleryServiceImp().takePhoto();
                        if (photoPath == null) return;
                        productProvider.updateProductImage([photoPath]);
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ]
                : null,
            title: selectProductState?.idProduct == null
                ? 'Agregar producto'
                : 'Editar producto',
            showTitle: true,
          ),
          floatingActionButton: isSaving
              ? const CircularProgressIndicator()
              : FloatingActionButton.extended(
                  onPressed: () {
                    register(
                      formKey,
                      selectProductState,
                      idProduct: selectProductState.idProduct,
                    );
                  },
                  icon: Icon(
                    selectProductState!.idProduct == null
                        ? Icons.add
                        : Icons.edit,
                  ),
                  label: Text(
                    selectProductState.idProduct == null
                        ? 'Registrar producto'
                        : 'Editar producto',
                  ),
                ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                selectProductState!.images.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 250,
                        width: 600,
                        child: ImageGallery(
                          images: selectProductState.images,
                          deleteImage: (image) {
                            productProvider.deleteImageToUpload(image);
                          },
                        ),
                      ),
                FormBuilder(
                  enabled: !isSaving,
                  key: formKey,
                  initialValue: {
                    'name': selectProductState.name,
                    'regular_price': selectProductState.price,
                    'description': selectProductState.description,
                    'category': selectProductState.category,
                    'tags': selectProductState.idTags,
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          formFieldName: 'category',
                          title: 'Categoria',
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> getUrlFileResult(String path) async {
    final uploadFile = await Request.uploadFileRequest(
      RequestType.post,
      'uploadFiles',
      {},
      File(path),
      useAuxiliarUrl: true,
    );

    return jsonDecode(uploadFile.body)['secure_url'];
  }

  Future<List<String>> uploadPhotos(List<String> photos) async {
    final photosToUpload =
        photos.where((element) => element.startsWith('/')).toList();
    final photosToIgnore =
        photos.where((element) => !element.startsWith('/')).toList();

    /* TODO crear una seria de futures de carga de imagenes */
    final List<Future<String>> uploadJob =
        photosToUpload.map(getUrlFileResult).toList();

    final newImages = await Future.wait(uploadJob);

    return [...photosToIgnore, ...newImages];
  }

  void register(
    GlobalKey<FormBuilderState> formkey,
    SelectedProduct selectedProduct, {
    int? idProduct,
  }) async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    formkey.currentState!.save();

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

    final imagesResult = await uploadPhotos(selectedProduct.images);
    final images = imagesResult.map((e) => {"src": e}).toList();
    json.addAll(
      {"images": images},
    );

    productsProvider
        .createOrUpdateProduct(
      json,
      idProduct: idProduct,
    )
        .then((value) {
      globalProvider.showSnackBar(
        context,
        idProduct == null ? 'Registro exitoso' : 'Actualizacion exitosa',
        backgroundColor: idProduct == null ? Colors.green : Colors.blue,
      );

      context.pop();
    }).catchError((error) {
      globalProvider.showSnackBar(
        context,
        'Error al registrar',
        backgroundColor: Colors.red,
      );
    });
  }
}
