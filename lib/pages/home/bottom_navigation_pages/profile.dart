part of '../../pages.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false).user;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProfile(authProvider: authProvider),
            const SimpleText(
              text: 'Información personal',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              top: 10,
              bottom: 5,
              lightThemeColor: Colors.deepPurple,
            ),
            subtitle(
                'Nombre',
                "${authProvider!.client!.firstName} ${authProvider.client!.lastName}"
                    .toTitleCase()),
            subtitle(
                'Direccion', authProvider.client!.address1!.toCapitalize()),
            subtitle('Telefono', authProvider.client!.phone!),
          ],
        ),
      ),
    );
  }
}

Widget subtitle(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          top: 5,
          bottom: 5,
          lightThemeColor: Colors.deepPurple,
        ),
        SimpleText(
          text: subtitle,
        ),
      ],
    ),
  );
}

class CardProfile extends StatelessWidget {
  const CardProfile({
    Key? key,
    required this.authProvider,
  }) : super(key: key);

  final LoginClientModel? authProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow,
            Colors.blue,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      width: 500,
      height: 200,
      child: Stack(
        children: [
          /* icon with opacitiy color */
          Positioned(
            top: -20,
            right: 0,
            child: Icon(
              Icons.home,
              color: Colors.yellow.withOpacity(0.4),
              size: 100,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: Colors.black.withOpacity(0.3),
                  size: 50,
                ),
                SimpleText(
                  text: authProvider!.client!.store!.name!.toTitleCase(),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 10),
                /* const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  /* size: 10, */
                ), */
              ],
            ),
          )
        ],
      ),
    );
  }
}
