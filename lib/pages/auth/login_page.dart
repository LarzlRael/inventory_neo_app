part of '../pages.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              /*  */
              child: BannerLogin(),
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
                    child: LoginPage(),
                    duration: Duration(milliseconds: 400),
                  ),
                );
              },
              labelButtonFontSize: 15,
              label: 'Iniciar sesión',
              ghostButton: true,
              backgroundColor: Colors.blue,
              borderRadius: 100,
            ),
            SimpleText(
              text: '¿Necesitas ayuda?, Contactanos',
            )
          ],
        ),
      ),
    );
  }
}
