part of '../pages.dart';

class CategoryForm {
  String name;
  int? id;
  String? urlImage;
  CategoryForm({required this.name, required this.id});
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
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as CategoryForm?;
    if (arguments != null) {
      categoryForm.name = arguments.name;
      categoryForm.id = arguments.id;
      categoryForm.urlImage = arguments.urlImage;
    }
    super.build(context);
    final formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title:
            categoryForm.id == null ? 'Agregar categorias' : 'Editar categoria',
        showTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              FormBuilder(
                initialValue: {
                  'name': categoryForm.name,
                  'file': categoryForm.urlImage,
                  'id': categoryForm.id,
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
              !_isLoading
                  ? FillButton(
                      onPressed: () {
                        register(formKey, categoryForm.id);
                      },
                      label: categoryForm.id == null ? 'Registrar' : 'Editar',
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

  void register(GlobalKey<FormBuilderState> formkey, int? idCategory) async {
    formkey.currentState!.save();

    final json = {
      "name": formkey.currentState!.value['name'],
      "image": {
        "src":
            await getUrlFileResult(formkey.currentState!.value['file'][0].path),
      },
    };
    setState(() {
      _isLoading = true;
    });
    if (idCategory != null) {
      await updateCategory(idCategory, json);
    } else {
      await postCategory(json);
    }
  }

  updateCategory(int idCategory, Map<String, dynamic> json) async {
    final update = await putAction('products/categories/$idCategory', json);

    if (validateStatus(update!.statusCode)) {
      GlobalSnackBar.show(
        context,
        'Actualizacion exitosa',
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
        'Error al actualizar',
        backgroundColor: Colors.red,
      );
    }
  }

  postCategory(Map<String, dynamic> json) async {
    final categoriesServices = CategoriesServices();
    final newCategory = await categoriesServices.newCategory(json);
    if (newCategory) {
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
