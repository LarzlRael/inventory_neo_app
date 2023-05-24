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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              child: Text(
                'Gestiona tu negocio',
                style: textTheme.titleSmall!.copyWith(
                  /* fontSize: 15, */
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: AlignedGridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                itemCount: menuAdminItems.length,
                itemBuilder: (context, index) => menuAdminItems[index],
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
    final textTheme = Theme.of(context).textTheme;
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
              ),
              const SizedBox(height: 5),
              Text(
                cardTitle,
                style: textTheme.titleSmall!.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
