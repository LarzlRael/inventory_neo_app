part of '../pages.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.network(
              'https://i.pinimg.com/736x/e6/18/30/e618308017485e881581fb31cd25ce8d--wallpaper-shelves-red-background.jpg',
              fit: BoxFit.cover,
            ),
            Opacity(
              opacity: 0.3, // Valor de opacidad (0.0 a 1.0)
              child: Container(
                color: Colors.black, // Color oscuro
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Holaaa!',
                          style: textTheme.titleSmall!.copyWith(
                            color: Color(0xffe8be98),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Bienvenido a la app de Joyeria Arrieta, aqui podras ver todos los productos que tenemos disponibles.',
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 0,
              child: CustomPaint(
                /* foregroundPainter: BackGroundCustomPainter(), */
                painter: BackGroundCustomPainter(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 35,
                  ),
                  height: size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35,
                        ),
                        child: Text(
                          'Deja que fue gente',
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      FormBuilder(
                        enabled: !loading,
                        key: _formKey,
                        child: Column(
                          children: [
                            const CustomLoginTextField(
                              placeholder: 'Numero de telefono',
                              icon: Icons.phone,
                              name: 'phone',
                              keyboardType: TextInputType.phone,
                            ),
                            const CustomLoginTextField(
                              placeholder: 'Contraseña',
                              icon: Icons.lock,
                              name: 'password',
                              passwordField: true,
                              /* keyboardType: TextInputType.phone, */
                            ),
                            loading
                                ? const CircularProgressIndicator()
                                : SizedBox(
                                    height: 45,
                                    width: double.infinity,
                                    child: FilledButton.icon(
                                      onPressed: () {
                                        saveForm(context);
                                      },
                                      icon: const Icon(Icons.phone),
                                      label: const Text('Iniciar sesión'),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Text('que fue gente'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveForm(BuildContext context) async {
    final authProvider = context.read<AuthProvider>();
    final globalProvider = context.read<GlobalProvider>();

    _formKey.currentState!.save();
    final data = {
      'phone': _formKey.currentState!.fields['phone']!.value,
      'password': _formKey.currentState!.fields['password']!.value,
    };

    authProvider.login(data).then((value) {
      if (value) {
        context.go('/home');
        globalProvider.showSnackBar(
          context,
          'Bienvenido',
          backgroundColor: Colors.green,
        );
        return;
      }
      globalProvider.showSnackBar(
        context,
        "Contraseña incorrecta",
        backgroundColor: Colors.red,
      );
    });
  }
}

class BackGroundCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffe8be98)
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    final path = Path();
    path.moveTo(0, size.height * 0.25);
// Dibujar el arco
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * -0.1, // Punto de control y
      size.width,
      size.height * 0.25,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
