part of '../pages.dart';

class ClientRegisterPage extends StatefulWidget {
  final ClientModel? clientModel;

  const ClientRegisterPage({super.key, this.clientModel});

  @override
  State<ClientRegisterPage> createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {
  bool isLoading = false;
  late ClientsProvider clientsProvider;
  late GlobalProvider globalProvider;

  @override
  void initState() {
    super.initState();
    clientsProvider = context.read<ClientsProvider>();
    globalProvider = context.read<GlobalProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    final textTheme = Theme.of(context).textTheme;

    final clientData = ClientModel(
      id: null,
      firstName: '',
      lastName: '',
      address1: '',
      phone: '',
      email: '',
      gender: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    if (widget.clientModel != null) {
      clientData.id = widget.clientModel!.id;
      clientData.firstName = widget.clientModel!.firstName;
      clientData.lastName = widget.clientModel!.lastName;
      clientData.address1 = widget.clientModel!.address1;
      clientData.phone = widget.clientModel!.phone;
    }

    final editable = clientData.id != null;

    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: editable
            ? "Edicion de cliente ${clientData.firstName} ${clientData.lastName}"
            : 'Registro de un nuevo cliente',
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            addOrEditClient(formKey, idClient: clientData.id);
          },
          icon: Icon(editable ? Icons.edit : Icons.save),
          label: Text(
            editable ? "Editar Cliente" : "Guardar cliente",
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                editable ? 'Editar cliente' : 'Agregar nuevo cliente',
                style: textTheme.titleSmall,
              ),
              Text(
                  editable
                      ? 'Edite los campos para actualizar el cliente'
                      : 'Por favor, rellene los campos para registrar un nuevo cliente',
                  style: textTheme.bodyMedium!
                    ..copyWith(
                      color: Colors.grey[600],
                    )),
              const SizedBox(height: 10),
              FormBuilder(
                initialValue: {
                  'first_name': clientData.firstName,
                  'last_name': clientData.lastName,
                  'address_1': clientData.address1,
                  'phone': clientData.phone,
                },
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      label: 'Nombre',
                      name: 'first_name',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Nombre es requerido'),
                          FormBuilderValidators.minLength(3),
                        ],
                      ),
                    ),
                    CustomTextField(
                      label: 'Apellidos',
                      name: 'last_name',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Apellidos es requerido'),
                          FormBuilderValidators.minLength(3),
                        ],
                      ),
                    ),
                    CustomTextField(
                      label: 'Dirección',
                      name: 'address_1',
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Dirección es requerido'),
                          FormBuilderValidators.minLength(3),
                        ],
                      ),
                    ),
                    CustomTextField(
                      label: 'Telefono',
                      name: 'phone',
                      keyboardType: TextInputType.phone,
                      validator: FormBuilderValidators.compose(
                        [
                          FormBuilderValidators.required(
                              errorText: 'Telefono es requerido'),
                          FormBuilderValidators.minLength(3),
                        ],
                      ),
                    ),
                    /* FormBuilderRadioGroup(
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
                    ), */
                  ],
                ),
              ),
              /*  isLoading
                  ? simpleLoading()
                  : FillButton(
                      onPressed: () {
                        addOrEditClient(formKey, idClient: clientData.id);
                      },
                      label: editable ? "Editar Cliente" : "Guardar cliente",
                    ), */
            ],
          ),
        ),
      ),
    );
  }

  addOrEditClient(GlobalKey<FormBuilderState> formKey, {int? idClient}) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState?.save();
    final currentData = formKey.currentState?.value;
    final data = {
      'firstName': currentData!['first_name'],
      'lastName': currentData['last_name'],
      'address1': currentData['address_1'],
      'phone': currentData['phone'],
    };

    clientsProvider.addOrEditClient(data, idClient: idClient).then((value) {
      context.pop();
      final message = idClient == null
          ? "Cliente guardado con exito"
          : "Cliente editado con exito";
      final color = idClient == null ? Colors.green : Colors.blue;
      globalProvider.showSnackBar(
        context,
        message,
        backgroundColor: color,
      );
    });
  }
}
