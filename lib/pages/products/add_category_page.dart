part of '../pages.dart';

class CategoryForm {
  String name;
  int? id;
  String? image;
  CategoryForm({required this.name, required this.id, this.image});
}

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = false;
  final categoryForm = CategoryForm(name: '', id: null);
  late CategoriesBloc categoriesBloc;
  @override
  void initState() {
    categoriesBloc = CategoriesBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryForm?;
    if (arguments != null) {
      categoryForm.name = arguments.name;
      categoryForm.id = arguments.id;
      categoryForm.image = arguments.image;
    }
    super.build(context);
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title:
            categoryForm.id == null ? 'Agregar categorias' : 'Editar categoria',
        showTitle: true,
        actions: [
          Visibility(
            visible: categoryForm.id != null,
            child: IconButton(
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
                    final response = await deleteAction(
                        'products/categories/${categoryForm.id}?force=true');
                    setState(() {
                      _isLoading = false;
                    });
                    if (!mounted) return;
                    if (validateStatus(response!.statusCode)) {
                      GlobalSnackBar.show(
                          context, "Categoria eliminado correctamente",
                          backgroundColor: Colors.green);
                      Navigator.pop(
                        context,
                      );
                      categoriesBloc.getCategories();
                    } else {
                      GlobalSnackBar.show(
                        context,
                        "No se pudo eliminar esta categoria",
                        backgroundColor: Colors.red,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                );
              },
            ),
          )
        ],
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
                        'file': categoryForm.image,
                        'id': categoryForm.id,
                        'imageUrl': categoryForm.image,
                      },
                      key: formKey,
                      onChanged: () {},
                      autovalidateMode: AutovalidateMode.disabled,
                      skipDisabled: true,
                      child: Column(
                        children: const [
                          CustomTextField(
                            label: 'Nombre de categoria',
                            name: 'name',
                          ),
                          CustomFileField(
                            name: 'file',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: categoryForm.image != null,
                      child: Image.network(
                        categoryForm.image ?? '',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    !_isLoading
                        ? FillButton(
                            onPressed: () {
                              register(formKey, categoryForm.id);
                            },
                            label: categoryForm.id == null
                                ? 'Registrar'
                                : 'Editar',
                          )
                        : simpleLoading(),
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

  void register(GlobalKey<FormBuilderState> formkey, int? idCategory) async {
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
    debugPrint(json.toString());

    if (idCategory != null) {
      await updateCategory(idCategory, json);
    } else {
      await postCategory(json);
    }
  }

  updateCategory(
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
  }

  responsePost(bool isok, String messageSuccess, String messageError) {
    if (isok) {
      GlobalSnackBar.show(
        context,
        messageSuccess,
        backgroundColor: Colors.green,
      );
      setState(() {
        _isLoading = false;
      });
      categoriesBloc.getCategories();
      Navigator.pop(
        context,
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      GlobalSnackBar.show(
        context,
        messageError,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
