part of '../pages.dart';

class ClientRegisterPage extends StatelessWidget {
  const ClientRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: 'Registro de un nuevo cliente',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
                text: 'Agregar nuevo cliente',
                bottom: 10,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            SimpleText(
              text:
                  'If you are creating project for and existing client please skip this step',
              fontSize: 14,
              lightThemeColor: Colors.black54,
            ),
            SizedBox(height: 20),
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    label: 'Nombre completo',
                    name: 'fullname',
                  ),
                  const CustomTextField(
                    label: 'Dirección',
                    name: 'direction',
                  ),
                  CustomTextField(
                    label: 'Telefono',
                    name: 'telephone',
                  ),
                  FormBuilderRadioGroup(
                    decoration: const InputDecoration(
                      labelText: 'Genero',
                      border: InputBorder.none,
                    ),
                    initialValue: null,
                    name: 'best_language',
                    /* onChanged: _onChanged, */
                    /* validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]), */
                    options: ['Hombre', 'Mujer']
                        .map(
                          (lang) => FormBuilderFieldOption(
                            value: lang,
                            child: Text(lang),
                          ),
                        )
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.trailing,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                  },
                  // color: Theme.of(context).colorScheme.secondary,
                  child:
                      FillButton(onPressed: () {}, label: "Guardar cliente")),
            ),
          ],
        ),
      ),
    );
  }
}
