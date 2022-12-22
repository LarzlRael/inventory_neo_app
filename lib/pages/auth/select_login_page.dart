part of '../pages.dart';

class SelectLoginPage extends StatelessWidget {
  const SelectLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        /* title: 'Iniciar sesión', */
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          width: double.infinity,
          /* color: Colors.blue, */
          child: Column(
            /* crossAxisAlignment: CrossAxisAlignment.end, */
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SimpleText(
                /* textAlign: TextAlign.center, */
                text: '¡Hola de nuevo!',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const Icon(
                Icons.tv,
                size: 200,
              ),
              Column(
                children: [
                  LoginButton(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
