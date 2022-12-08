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

class FutureSubjectCategory extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoriesServices.getCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoriesModel>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: title,
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
                  name: formFieldName,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  /* initialValue: category[0], */
                  hint: Text(placeholder),
                  /* validator: FormBuilderValidators.required(), */
                  items: snapshot.data!
                      .map((category) => DropdownMenuItem(
                          value: category.name, child: Text(category.name)))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
