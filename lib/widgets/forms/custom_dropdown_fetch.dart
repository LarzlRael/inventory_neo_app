part of '../widgets.dart';

class CustomFormBuilderFetchDropdown extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  final List<CategoriesModel> categories;
  const CustomFormBuilderFetchDropdown({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              /* validator: FormBuilderValidators.required(), */
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
              items: categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category.id,
                      child: Text(
                        category.name,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

/* class FutureSubjectCategory extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  FutureSubjectCategory({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  final List<CategoriesModel> category = [];

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Column(
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
                    items: category
                        .map(
                          (category) => DropdownMenuItem(
                            value: category.id,
                            child: Text(
                              category.name,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
 */