part of '../widgets.dart';

class CustomRadioButtons extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  final List<String> options;
  final List<TagsModel> materiales;
  const CustomRadioButtons({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.options,
    required this.materiales,
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
        const SizedBox(width: 10),
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilderCheckboxGroup<String>(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              name: formFieldName,
              initialValue: options,
              options: materiales
                  .map(
                    (tag) => FormBuilderFieldOption(
                      value: tag.id.toString(),
                      child: MaterialItemCard(tag: tag),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}
