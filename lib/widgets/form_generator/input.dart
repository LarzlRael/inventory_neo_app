part of '../widgets.dart';

class Input extends StatelessWidget {
  final FormModel formModel;
  const Input({
    super.key,
    required this.formModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(formModel.label),
        FormBuilderTextField(
          name: formModel.name,
          validator: formModel.validator,
          autovalidateMode: AutovalidateMode.always,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          keyboardType: formModel.inputType,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
