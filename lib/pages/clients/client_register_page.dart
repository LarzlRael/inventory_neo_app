part of '../pages.dart';

class ClientData {
  int? idClient;
  String name;
  String lastName;
  String address;
  String phone;
  String email;
  ClientData({
    this.idClient,
    required this.name,
    required this.lastName,
    required this.address,
    required this.phone,
    required this.email,
  });
}

class ClientRegisterPage extends StatefulWidget {
  const ClientRegisterPage({super.key});

  @override
  State<ClientRegisterPage> createState() => _ClientRegisterPageState();
}

class _ClientRegisterPageState extends State<ClientRegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    final args = ModalRoute.of(context)!.settings.arguments as ClientData?;
    final clientData = ClientData(
      idClient: null,
      name: '',
      lastName: '',
      address: '',
      phone: '',
      email: '',
    );
    if (args != null) {
      clientData.idClient = args.idClient;
      clientData.name = args.name;
      clientData.lastName = args.lastName;
      clientData.address = args.address;
      clientData.phone = args.phone;
    }

    final editable = clientData.idClient != null;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: editable
            ? "Edicion de cliente ${clientData.name} ${clientData.lastName}"
            : 'Registro de un nuevo cliente',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                  text: editable ? 'Editar cliente' : 'Agregar nuevo cliente',
                  bottom: 10,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              const SimpleText(
                text:
                    'Por favor, rellene los campos para registrar un nuevo cliente',
                fontSize: 14,
                lightThemeColor: Colors.black54,
              ),
              const SizedBox(height: 20),
              FormBuilder(
                initialValue: {
                  'first_name': clientData.name,
                  'last_name': clientData.lastName,
                  'address_1': clientData.address,
                  'phone': clientData.phone,
                },
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomTextField(
                      label: 'Nombre',
                      name: 'first_name',
                    ),
                    CustomTextField(
                      label: 'Apellidos',
                      name: 'last_name',
                    ),
                    CustomTextField(
                      label: 'Dirección',
                      name: 'address_1',
                    ),
                    CustomTextField(
                      label: 'Telefono',
                      name: 'phone',
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
              FillButton(
                onPressed: () {
                  addOrEditClient(_formKey, idClient: clientData.idClient);
                },
                label: editable ? "Editar Cliente" : "Guardar cliente",
              ),
            ],
          ),
        ),
      ),
    );
  }

  addOrEditClient(GlobalKey<FormBuilderState> formKey, {int? idClient}) async {
    formKey.currentState?.save();
    final currentData = formKey.currentState?.value;
    final clientsServices = ClientsServices();
    final data = {
      'first_name': currentData!['first_name'],
      'last_name': currentData['last_name'],
      'email':
          "${currentData['first_name']}${currentData['last_name']}@gmail.com"
              .replaceAll(' ', ''),
      'billing': {
        'address_1': currentData['address_1'],
        'phone': currentData['phone'],
      }
    };
    bool ok;
    if (idClient == null) {
      ok = await clientsServices.addClient(data);
    } else {
      ok = await clientsServices.editClient(idClient, data);
    }
    if (!mounted) return;
    if (ok) {
      GlobalSnackBar.show(context, "Cliente guardado con exito",
          backgroundColor: Colors.green);
    } else {
      GlobalSnackBar.show(context, "Hubo un error al guardar el cliente",
          backgroundColor: Colors.red);
    }

    debugPrint(data.toString());
  }
}
