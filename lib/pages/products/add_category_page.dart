part of '../pages.dart';

class CategoryForm {
  String name;
  int? id;
  String? image;
  CategoryForm({required this.name, required this.id, this.image});
}

class AddCategoryPage extends StatefulWidget {
  final CategoryForm? categoryForm;
  const AddCategoryPage({super.key, this.categoryForm});

  @override
  State<AddCategoryPage> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategoryPage> {
  bool _isLoading = false;
  final categoryForm = CategoryForm(name: '', id: null);
  /* late CategoriesBloc categoriesBloc; */
  @override
  void initState() {
    /* categoriesBloc = CategoriesBloc(); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final globalProvider = context.read<GlobalProvider>();
    if (categoryForm.id != null) {
      categoryForm.name = categoryForm.name;
      categoryForm.id = categoryForm.id;
      categoryForm.image = categoryForm.image;
    }
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          categoryForm.id == null ? 'Agregar categoria' : 'Editar categoria',
        ),
        icon: Icon(categoryForm.id == null ? Icons.save : Icons.edit),
        onPressed: () {
          context.push('/add_categories_page');
        },
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title:
            categoryForm.id == null ? 'Agregar categoria' : 'Editar categoria',
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
                    deleteAction(
                            'products/categories/${categoryForm.id}?force=true')
                        .then((value) {
                      if (validateStatus(value!.statusCode)) {
                        globalProvider.showSnackBar(
                          context,
                          "Categoria eliminado correctamente",
                          backgroundColor: Colors.green,
                        );
                        /* TODO change this in a categories provider */
                        /* categoriesBloc.getCategories(); */
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
                        children: [
                          CustomTextField(
                            label: 'Nombre de categoria',
                            name: 'name',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: "Este campo es requerido"),
                            ]),
                          ),
                          const CustomFileField(
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
    final globalProvider = context.read<GlobalProvider>();
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
