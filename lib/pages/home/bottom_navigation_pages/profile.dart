part of '../../pages.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Container(
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
                      const Text('Profile'),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        /* size: 10, */
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
