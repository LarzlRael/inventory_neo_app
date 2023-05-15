part of '../../pages.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  'Gestiona tu negocio',
                  style: textTheme.titleMedium,
                  /*  fontSize: 15,
                  fontWeight: FontWeight.w700, */
                )),
            SizedBox(
              /* fit: FlexFit.tight, */
              height: MediaQuery.of(context).size.height * 0.25,
              child: GridView.count(
                /* shrinkWrap: true, */
                /* physics: NeverScrollableScrollPhysics(), */
                /* padding: const EdgeInsets.all(10), */
                childAspectRatio: 3 / 2,
                crossAxisCount: 3,
                children: const [
                  /* ManagementCards(
                    cardTitle: 'Empleados',
                    cardIcon: Icons.person_pin_circle,
                    cardRoute: 'clients',
                  ), */
                  ManagementCards(
                      cardTitle: 'Clientes',
                      cardIcon: Icons.person,
                      cardRoute: 'clients'),
                  ManagementCards(
                    cardTitle: 'Productos',
                    cardIcon: Icons.production_quantity_limits,
                    cardRoute: 'list_products_page',
                  ),
                  ManagementCards(
                    cardTitle: 'Vender producto',
                    cardIcon: Icons.sell,
                    cardRoute: 'sell_products',
                  ),
                  ManagementCards(
                    cardTitle: 'Historial de ventas',
                    cardIcon: Icons.history,
                    cardRoute: 'sell_history',
                  ),
                ],
              ),
            ),
            /*  const SimpleText(
              text: 'Que tus clientes te conozcan',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              top: 25,
              bottom: 5,
            ), */
          ],
        ),
      ),
    );
  }
}

class ManagementCards extends StatelessWidget {
  final String cardTitle;
  final IconData cardIcon;
  final String cardRoute;
  const ManagementCards({
    Key? key,
    required this.cardTitle,
    required this.cardIcon,
    required this.cardRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(cardRoute);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: FittedBox(
            child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Icon(cardIcon),
              const SizedBox(
                height: 5,
              ),
              SimpleText(
                text: cardTitle,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
