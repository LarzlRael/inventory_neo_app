part of '../../pages.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: 'Gestiona tu negocio',
              style: textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              // Envuelve el ListView en un Expanded widget
              child: ListView(
                children: [
                  AlignedGridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuAdminItems.length,
                    itemBuilder: (context, index) {
                      return menuAdminItems[index];
                    },
                  ),
                  const SimpleText(
                    text: 'Que tus clientes te conozcan',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    /* top: 5,
                    bottom: 5, */
                  ),
                ],
              ),
            ),
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
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
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
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Icon(
                cardIcon,
                size: 25,
                color: colors.primary,
              ),
              const SizedBox(height: 5),
              Hero(
                tag: cardTitle,
                child: Text(
                  cardTitle,
                  style: textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
