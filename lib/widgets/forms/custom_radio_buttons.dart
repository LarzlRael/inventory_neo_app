part of '../widgets.dart';

class CustomRadioButtons extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  const CustomRadioButtons({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagsServices = TagsServices();
    return FutureMaterialCategory(
        title: title,
        tagsServices: tagsServices,
        formFieldName: formFieldName,
        placeholder: placeholder);
  }
}

class FutureMaterialCategory extends StatelessWidget {
  final TagsServices tagsServices;
  final String title;
  final String formFieldName;
  final String placeholder;
  const FutureMaterialCategory({
    Key? key,
    required this.tagsServices,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tagsServices.getAllTags(),
      builder: (BuildContext context, AsyncSnapshot<List<TagsModel>> snapshot) {
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
                child: FormBuilderCheckboxGroup<String>(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    /* hintText: placeholder, */
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  name: formFieldName,
                  // initialValue: const ['Dart'],
                  options: snapshot.data!
                      .map((tag) => FormBuilderFieldOption(
                            value: tag.name,
                            child: Text(tag.name),
                          ))
                      .toList(growable: false),
                  /* onChanged: _onChanged, */
                  separator: const VerticalDivider(
                    width: 10,
                    thickness: 5,
                    color: Colors.red,
                  ),
                  /*    validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.maxLength(3),
                      ]), */
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
