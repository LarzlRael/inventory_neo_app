part of '../../pages.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              crossAxisCount: 2,
              children: registerOptions(context).map((category) {
                return (category);
              }).toList()),
        ),
      ]),
    );
  }
}
