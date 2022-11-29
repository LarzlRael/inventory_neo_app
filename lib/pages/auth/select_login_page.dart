part of '../pages.dart';

class SelectLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          /* color: Colors.blue, */
          child: Column(
            /* crossAxisAlignment: CrossAxisAlignment.end, */
            children: [
              SimpleText(
                /* textAlign: TextAlign.center, */
                text: '¡Hola de nuevo!',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              Icon(
                Icons.tv,
                size: 200,
              ),
              LoginButton(
                onPressed: () {},
                paddingVertical: 12,
                spaceBetweenIconAndText: 15,
                label: 'Iniciar sesión con Google',
                fontSize: 15,
                backGroundColor: Colors.blue,
                icon: Icons.g_mobiledata,
                textColor: Colors.white,
              ),
              LoginButton(
                onPressed: () {},
                paddingVertical: 12,
                spaceBetweenIconAndText: 15,
                label: 'Con numero de celular',
                fontSize: 15,
                ghostButton: true,
                backGroundColor: Colors.blue,
                icon: Icons.phone,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
