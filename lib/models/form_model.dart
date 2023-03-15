part of 'models.dart';

class FormModel {
  String label;
  String name;
  String? value;
  String? type;
  TextInputType? inputType;
  String? Function(String?)? validator;
  FormModel({
    required this.label,
    required this.name,
    this.value,
    this.type = 'input',
    this.inputType = TextInputType.text,
    this.validator,
  });
}
