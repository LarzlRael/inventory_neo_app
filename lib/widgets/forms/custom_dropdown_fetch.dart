part of '../widgets.dart';

class CustomFormBuilderFetchDropdown extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  const CustomFormBuilderFetchDropdown({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesServices = CategoriesServices();
    return FutureSubjectCategory(
        title: title,
        categoriesServices: categoriesServices,
        formFieldName: formFieldName,
        placeholder: placeholder);
  }
}

class FutureSubjectCategory extends StatefulWidget {
  final CategoriesServices categoriesServices;
  final String title;
  final String formFieldName;
  final String placeholder;
  const FutureSubjectCategory({
    Key? key,
    required this.categoriesServices,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  State<FutureSubjectCategory> createState() => _FutureSubjectCategoryState();
}

class _FutureSubjectCategoryState extends State<FutureSubjectCategory>
    with AutomaticKeepAliveClientMixin {
  final List<CategoriesModel> category = [];

  @override
  initState() {
    super.initState();
    widget.categoriesServices.getCategories().then((value) {
      setState(() {
        category.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: widget.title,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          width: 10,
        ),
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilderDropdown(
              name: widget.formFieldName,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              /* initialValue: category[0], */
              hint: Text(widget.placeholder),
              /* validator: FormBuilderValidators.required(), */
              items: category
                  .map((category) => DropdownMenuItem(
                      value: category.id, child: Text(category.name)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
