part of '../pages.dart';

class CategoryForm {
  String name;
  int? id;
  String? image;
  CategoryForm({required this.name, required this.id, this.image});
}

class AddCategoryPage extends StatefulWidget {
  final CategoryForm? categoryFormParams;
  const AddCategoryPage({super.key, this.categoryFormParams});

  @override
  State<AddCategoryPage> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage> {
  bool _isLoading = false;
  CategoryForm categoryForm = CategoryForm(name: '', id: null);

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
    if (widget.categoryFormParams?.id != null) {
      categoryForm.id = widget.categoryFormParams!.id;
      categoryForm.name = widget.categoryFormParams!.name;
      categoryForm.image = widget.categoryFormParams!.image;
    }

    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          categoryForm.id == null ? 'Agregar categoria' : 'Editar categoria',
        ),
        icon: Icon(categoryForm.id == null ? Icons.save : Icons.edit),
        onPressed: () {
          register(formKey, categoryForm.id);
        },
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title:
            categoryForm.id == null ? 'Agregar categoria' : 'Editar categoria',
        showTitle: true,
        actions: categoryForm.id != null
            ? [
                /*  IconButton(
                  onPressed: () async {
                    final photoPath =
                        await CamerGalleryServiceImp().selectFromGallery();
                    if (photoPath == null) return;
                    categoryForm.image = photoPath;
                    setState(() {});
                    print(categoryForm.image);
                  },
                  icon: const Icon(Icons.photo_album),
                ), */
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    asyncShowConfirmDialog(
                      context,
                      'Eliminar categoria',
                      '¿Estas seguro de eliminar esta categoria?',
                      () async {
                        setState(() {
                          _isLoading = true;
                        });
                        categoriesMaterialProviders
                            .deleteCategory(categoryForm.id!)
                            .then((value) {
                          if (value) {
                            globalProvider.showSnackBar(
                              context,
                              "Categoria eliminado correctamente",
                              backgroundColor: Colors.green,
                            );
                            context.pop();
                          } else {
                            globalProvider.showSnackBar(
                              context,
                              "No se pudo eliminar esta categoria",
                              backgroundColor: Colors.red,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        });
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    );
                  },
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: !_isLoading
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    FormBuilder(
                      initialValue: {
                        'name': categoryForm.name,
                        /* 'file': categoryForm.image, */
                        'id': categoryForm.id,
                        'imageUrl': categoryForm.image,
                      },
                      key: formKey,
                      onChanged: () {},
                      autovalidateMode: AutovalidateMode.disabled,
                      skipDisabled: true,
                      child: Column(
                        children: [
                          categoryForm.image != null
                              ? SizedBox(
                                  height: 250,
                                  width: 600,
                                  child: ImageGallery(
                                    /* change this by the original */
                                    images: [categoryForm.image!],
                                  ),
                                )
                              : const SizedBox(),
                          CustomTextField(
                            label: 'Nombre de categoria',
                            name: 'name',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Este campo es requerido"),
                            ]),
                          ),
                          const CustomFileField(name: 'file'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    /* !_isLoading
                        ? FillButton(
                            onPressed: () {
                              register(formKey, categoryForm.id);
                            },
                            label: categoryForm.id == null
                                ? 'Registrar'
                                : 'Editar',
                          )
                        : simpleLoading(), */
                  ],
                ),
              )
            : simpleLoading(),
      ),
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

  void register(GlobalKey<FormBuilderState> formkey, int? idCategory) async {
    if (!formkey.currentState!.validate()) {
      return;
    }
    formkey.currentState!.save();
    bool isFile = formkey.currentState!.value['file'] != null;
    setState(() {
      _isLoading = true;
    });
    final json = {
      "name": formkey.currentState!.value['name'],
      idCategory != null ? "id" : "": idCategory,
    };
    if (isFile && formkey.currentState!.value['file'].length > 0) {
      json.addAll(
        {
          "image": {
            "src": await getUrlFileResult(
                formkey.currentState!.value['file'][0].path)
          }
        },
      );
    }

    categoriesMaterialProviders
        .addOrEditCategory(json, idCategory: idCategory)
        .then((value) {
      if (value) {
        responsePost(
          value,
          'Categoria actualizada',
          'Error al actualizar registro',
        );
      } else {
        responsePost(
          value,
          'Hubo un error',
          'Hubo un error al actualizar registro',
        );
      }
    });
  }

  /*  updateCategory(
    int idCategory,
    Map<String, dynamic> json,
  ) async {
    final updateCategory =
        await putAction('products/categories/$idCategory', json);
    responsePost(
      validateStatus(updateCategory!.statusCode),
      'Categoria actualizada',
      'Error al actualizar registro',
    );
  }

  postCategory(
    Map<String, dynamic> json,
  ) async {
    final newCategory = await postAction('products/categories/', json);

    responsePost(
      validateStatus(newCategory!.statusCode),
      'Categoria registrada',
      'Error al registrar',
    );
  } */

  responsePost(bool isok, String messageSuccess, String messageError) {
    if (isok) {
      globalProvider.showSnackBar(
        context,
        messageSuccess,
        backgroundColor: Colors.green,
      );
      /* Change this */
      /* categoriesBloc.getCategories(); */
      setState(() {
        _isLoading = false;
      });
      context.pop();
    } else {
      setState(() {
        _isLoading = false;
      });
      globalProvider.showSnackBar(
        context,
        messageError,
        backgroundColor: Colors.red,
      );
    }
  }
}
