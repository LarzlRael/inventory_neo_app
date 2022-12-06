part of '../../pages.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CategoryCard(
          id: '14',
          title: 'Anillos',
          urlImage:
              'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
          color: Colors.blue,
        ),
      ),
    );
  }
}
