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

class FutureMaterialCategory extends StatefulWidget {
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
  State<FutureMaterialCategory> createState() => _FutureMaterialCategoryState();
}

class _FutureMaterialCategoryState extends State<FutureMaterialCategory>
    with AutomaticKeepAliveClientMixin {
  @override
  initState() {
    super.initState();
    widget.tagsServices.getAllTags().then((value) {
      setState(() {
        tags.addAll(value);
      });
    });
  }

  final List<TagsModel> tags = [];

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
            child: FormBuilderCheckboxGroup<String>(
              decoration: const InputDecoration(
                border: InputBorder.none,
                /* hintText: placeholder, */
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,

              name: widget.formFieldName,
              // initialValue: const ['Dart'],
              options: tags
                  .map(
                    (tag) => FormBuilderFieldOption(
                      value: tag.id.toString(),
                      child: MaterialItemCard(tag: tag),
                    ),
                  )
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
  }

  @override
  bool get wantKeepAlive => true;
}
