part of 'pages.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthProvider>(context, listen: false);

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
    final isAuthenticated = await authServices.renewToken();
    if (isAuthenticated) {
      goToInitialPage(context, const HomePage());
    } else {
      goToInitialPage(context, const LoginPage());
    }
  }
}

goToInitialPage(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    (route) => false,
  );
}
