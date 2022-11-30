part of '../../pages.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: 'Gestiona tu negocio',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              top: 5,
              bottom: 5,
            ),
            Container(
              /* fit: FlexFit.tight, */
              height: MediaQuery.of(context).size.height * 0.2,
              child: GridView.count(
                /* shrinkWrap: true, */
                /* physics: NeverScrollableScrollPhysics(), */
                /* padding: const EdgeInsets.all(10), */
                childAspectRatio: 3 / 2,
                crossAxisCount: 3,
                children: const [
                  ManagementCards(),
                  ManagementCards(),
                  ManagementCards(),
                  ManagementCards(),
                  ManagementCards(),
                  ManagementCards(),
                ],
              ),
            ),
            SimpleText(
              text: 'Que tus clientes te conozcan',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              top: 25,
              bottom: 5,
            ),
          ],
        ),
      ),
    );
  }
}

class ManagementCards extends StatelessWidget {
  const ManagementCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: FittedBox(
          child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Icon(Icons.person_add_alt),
            SizedBox(
              height: 5,
            ),
            SimpleText(
              text: 'Empleados',
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      )),
    );
  }
}
