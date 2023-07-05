part of '../widgets.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String name;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.label,
    required this.name,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SimpleText(
            text: label,
            fontSize: 15,
            color: Colors.black87,
            padding: const EdgeInsets.only(bottom: 2),
            fontWeight: FontWeight.w600,
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: FormBuilderTextField(
              validator: validator,
              autovalidateMode: AutovalidateMode.always,
              name: name,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                /* labelText: 'Nombre completo', */
                /* Remove border */
                border: OutlineInputBorder(),
              ),
              // valueTransformer: (text) => num.tryParse(text),
              // initialValue: '12',
              keyboardType: keyboardType,
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}
