part of 'utils.dart';

final List<FormModel> firstForm = [
  FormModel(
    label: 'Nombre',
    name: 'name',
    value: 'Steve',
  ),
  FormModel(
    label: 'Apellido',
    name: 'lastname',
    type: 'input',
    validator: FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Este campo es requerido'),
      FormBuilderValidators.minLength(3, errorText: 'Minimo 3 caracteres'),
    ]),
  ),
  FormModel(
    label: 'Email',
    name: 'email',
  ),
];
