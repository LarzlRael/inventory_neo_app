part of 'pages.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late AuthProvider authServices;

  @override
  void initState() {
    authServices = context.read<AuthProvider>();
    checkLoginState(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future checkLoginState(BuildContext context) {
    return authServices.renewToken().then(
      (value) {
        if (value) {
          /* goToInitialPage(context, '/home'); */
          context.go('/home');
        } else {
          context.go('/welcome_page');
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
