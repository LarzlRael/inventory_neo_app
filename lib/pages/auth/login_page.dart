part of '../pages.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        /* title: 'Iniciar sesión', */
      ), */
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              /*  */
              child: const BannerLogin(),
            ),
            /* FillButton(
              onPressed: () {},
              label: 'Crear cuenta',

              /* ghostButton: true, */
              backgroundColor: Colors.green,
              borderRadius: 100,
              marginVertical: 10,
            ), */
            FillButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: SelectLoginPage(),
                    duration: const Duration(milliseconds: 400),
                  ),
                );
              },
              labelButtonFontSize: 15,
              label: 'Iniciar sesión',
              ghostButton: true,
              backgroundColor: Colors.blue,
              borderRadius: 100,
            ),
            const SimpleText(
              text: '¿Necesitas ayuda?, Contactanos',
            )
          ],
        ),
      ),
    );
  }
}
