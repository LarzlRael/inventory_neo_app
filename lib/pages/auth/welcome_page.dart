part of '../pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: colors.primary), //<-- SEE HERE
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.bottomToTop,
                      child: const LoginPage(),
                      duration: const Duration(milliseconds: 400),
                    ),
                  );
                },
                child: const Text('Iniciar sesión'),
                /* labelButtonFontSize: 15,
                label: 'Iniciar sesión',
                ghostButton: true,
                /* backgroundColor: Colors.blue, */
                borderRadius: 100, */
              ),
            ),
            SimpleText(
              text: '¿Necesitas ayuda?, Contactanos',
              style: textTheme.bodyMedium!.copyWith(color: colors.primary),
            )
          ],
        ),
      ),
    );
  }
}
