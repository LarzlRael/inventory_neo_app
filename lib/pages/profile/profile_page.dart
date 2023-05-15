part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        /* title: 'Iniciar sesión', */
        actions: [
          IconButton(
            onPressed: () {
              asyncShowConfirmDialog(
                context,
                'Cerrar sesión',
                '¿Estás seguro de cerrar sesion?',
                () async {
                  authProvider.logout();
                  context.go(
                    '/login',
                  );
                },
              );
            },
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
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
