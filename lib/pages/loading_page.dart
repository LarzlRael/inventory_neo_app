part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = context.read<AuthProvider>();

    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context, authServices),
        builder: (_, __) {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future checkLoginState(
    BuildContext context,
    AuthProvider authServices,
  ) async {
    await authServices.renewToken().then(
      (value) {
        if (value) {
          goToInitialPage(context, '/home');
        } else {
          goToInitialPage(context, '/loading');
        }
      },
    );
  }
}

goToInitialPage(BuildContext context, String page) {
  /* Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    (route) => false,
  ); */
  context.go(page);
}
