part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        /* title: 'Iniciar sesión', */
      ),
      body: Center(
        child: Container(
          color: Colors.blue,
          width: 500,
          height: 300,
        ),
      ),
    );
  }
}
