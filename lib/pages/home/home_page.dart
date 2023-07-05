part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final titles = [
    'Inicio',
    'Registro',
    'Inventario',
    'Perfil',
  ];
  String currentTitle = "Inicio";
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final categoriesMaterialProviders =
        context.read<CategoriesMaterialProviders>();
    categoriesMaterialProviders.getFetchMaterialTags();
    categoriesMaterialProviders.getFetchCategories();
    return Scaffold(
      appBar: AppBar(
        /*   iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ), */
        title: Text(
          currentTitle,
          /* style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ), */
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showConfirmDialog(
                context,
                'Cerrar sesión',
                '¿Estás seguro de cerrar sesion?',
                () async {
                  authProvider.logout();
                  context.go('/login_page');
                },
              );
            },
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
        /* leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.bottomToTop,
                child: const ProfilePage(),
                duration: const Duration(milliseconds: 400),
              ),
            );
          },
          icon: const Icon(Icons.menu_rounded),
          //replace with our own icon data.
        ), */
      ),
      /* Delete back icon  */

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        /* selectedItemColor: Colors.amber[800], */
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            currentTitle = titles[index];
          });
        },
      ),
      body: bottomItemsWithLogin.elementAt(_selectedIndex),
    );
  }
}
