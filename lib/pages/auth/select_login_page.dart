part of '../pages.dart';

class SelectLoginPage extends StatefulWidget {
  SelectLoginPage({super.key});

  @override
  State<SelectLoginPage> createState() => _SelectLoginPageState();
}

class _SelectLoginPageState extends State<SelectLoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Iniciar sesión',
        showTitle: false,
      ), */
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          /* color: Colors.blue, */

          child: SingleChildScrollView(
            child: Column(
              /* crossAxisAlignment: CrossAxisAlignment.end, */
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SimpleText(
                  /* textAlign: TextAlign.center, */
                  text: '¡Hola de nuevo!',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                /* const Icon(
                  Icons.tv,
                  size: 200,
                ), */
                Column(
                  children: [
                    /* LoginButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: const HomePage(),
                            duration: const Duration(milliseconds: 400),
                          ),
                        );
                      },
                      paddingVertical: 12,
                      spaceBetweenIconAndText: 15,
                      label: 'Iniciar sesión con Google',
                      fontSize: 15,
                      backGroundColor: Colors.blue,
                      icon: Icons.g_mobiledata,
                      textColor: Colors.white,
                    ), */
                    FormBuilder(
                      enabled: !loading,
                      key: _formKey,
                      child: Column(
                        children: const [
                          CustomLoginTextField(
                            placeholder: 'Numero de telefono',
                            icon: Icons.phone,
                            name: 'phone',
                            keyboardType: TextInputType.phone,
                          ),
                          CustomLoginTextField(
                            placeholder: 'Contraseña',
                            icon: Icons.password,
                            name: 'password',
                            passwordField: true,
                            /* keyboardType: TextInputType.phone, */
                          ),
                        ],
                      ),
                    ),
                    loading
                        ? const CircularProgressIndicator()
                        : /* LoginButton(
                            onPressed: () {
                              saveForm(context);
                            },
                            paddingVertical: 12,
                            spaceBetweenIconAndText: 15,
                            label: 'Con numero de celular',
                            fontSize: 15,
                            /* ghostButton: true, */
                            backGroundColor: Colors.blue,
                            icon: Icons.phone,
                            textColor: Colors.white,
                          ), */
                        SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () {
                                saveForm(context);
                              },
                              icon: Icon(Icons.phone),
                              label: Text('Iniciar sesión'),
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveForm(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _formKey.currentState!.save();
    final data = {
      'phone': _formKey.currentState!.fields['phone']!.value,
      'password': _formKey.currentState!.fields['password']!.value,
    };

    final body = await authProvider.login(data);
    if (body) {
      Navigator.pushReplacementNamed(context, 'home');
      GlobalSnackBar.show(context, "Bienvenido", backgroundColor: Colors.green);
    } else {
      GlobalSnackBar.show(context, "Contraseña incorrecta",
          backgroundColor: Colors.red);
    }
  }
}
