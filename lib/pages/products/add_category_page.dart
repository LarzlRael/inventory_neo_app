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
  State<AddCategoryPage> createState() => _AddProductState();
}

class _AddProductState extends State<AddCategoryPage>
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
                        register(formKey);
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

  void register(GlobalKey<FormBuilderState> formkey) async {
    formkey.currentState!.save();
    final categoriesServices = CategoriesServices();

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
    final correct = await categoriesServices.newCategory(json);

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
