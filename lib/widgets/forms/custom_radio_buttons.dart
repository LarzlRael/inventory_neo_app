part of '../widgets.dart';

class CustomRadioButtons extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  final List<String> options;
  const CustomRadioButtons({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagsServices = TagsServices();
    return FutureMaterialCategory(
      title: title,
      tagsServices: tagsServices,
      formFieldName: formFieldName,
      placeholder: placeholder,
      options: options,
    );
  }
}

class FutureMaterialCategory extends StatefulWidget {
  final TagsServices tagsServices;
  final String title;
  final String formFieldName;
  final String placeholder;
  final List<String> options;
  const FutureMaterialCategory({
    Key? key,
    required this.tagsServices,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.options,
  }) : super(key: key);

  @override
  State<FutureMaterialCategory> createState() => _FutureMaterialCategoryState();
}

class _FutureMaterialCategoryState extends State<FutureMaterialCategory>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  @override
  initState() {
    super.initState();
    widget.tagsServices.getAllTags().then((value) {
      setState(() {
        tags.addAll(value);
        _isLoading = false;
      });
    });
  }

  final List<TagsModel> tags = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return !_isLoading
        ? Column(
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
                    initialValue: widget.options,
                    options: tags
                        .map(
                          (tag) => FormBuilderFieldOption(
                            value: tag.id.toString(),
                            child: MaterialItemCard(tag: tag),
                          ),
                        )
                        .toList(growable: false),
                    /* onChanged: _onChanged, */

                    /*    validator: FormBuilderValidators.compose([
                        FormBuilderValidators.minLength(1),
                        FormBuilderValidators.maxLength(3),
                      ]), */
                  ),
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  bool get wantKeepAlive => true;
}
