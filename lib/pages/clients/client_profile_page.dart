part of '../pages.dart';

class ClientProfilePage extends StatelessWidget {
  const ClientProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientModel clientModel =
        ModalRoute.of(context)!.settings.arguments as ClientModel;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
      ),
      backgroundColor: const Color(0xffcdd2f9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.deepPurple,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 75,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNzpQcuyrPhyGRcfnvBIAnR5rdIhImb3SZydxeWy_d&s'),
                  ),
                  SimpleText(
                    text: '${clientModel.firstName} ${clientModel.lastName}'
                        .toTitleCase(),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    top: 10,
                    bottom: 5,
                    lightThemeColor: Colors.white,
                  ),
                  SimpleText(
                    text: clientModel.billing.address1,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    lightThemeColor: Colors.white,
                  ),
                ],
              ),
            ),
            _tabSection(context, clientModel),
          ],
        ),
      ),
    );
  }

  Widget _tabSection(BuildContext context, ClientModel clientModel) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: const TabBar(
              labelColor: Colors.deepPurple,
              tabs: [
                Tab(text: "Cliente"),
                Tab(text: "Compras"),
              ],
            ),
          ),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height * 0.6,
            child: TabBarView(
              children: [
                cardContainer('Informacion del cliente', [
                  cardInformation(
                    'Telefono',
                    clientModel.billing.phone,
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.phone_android_rounded),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                        IconButton(
                          icon: Icon(Icons.message_rounded),
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  /* cardInformation(
                    'Genero',
                    'Varon',
                    null,
                  ), */
                  cardInformation(
                    'Cliente desde: ',
                    literalDate(clientModel.dateCreated),
                    null,
                  ),
                  cardInformation(
                    'Ultima compra realizada en',
                    '2020-01-02',
                    null,
                  ),
                ]),
                cardContainer(
                  'Historial de compras',
                  [
                    const NoInformation(
                      icon: Icons.shopping_bag_outlined,
                      text: 'No hay compras realizadas',
                      showButton: false,
                      iconButton: Icons.add,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardInformation(String title, String value, Widget? extraInformation) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            /* mainAxisAlignment: MainAxisAlignment.start, */
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                lightThemeColor: Colors.black26,
              ),
              SimpleText(
                top: 3,
                text: value,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                lightThemeColor: Colors.black54,
              ),
            ],
          ),
          extraInformation ?? Container(),
        ],
      ),
    );
  }

/* params array widget */

  Widget cardContainer(
    String title,
    List<Widget> children,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                top: 10,
                bottom: 5,
                lightThemeColor: Colors.deepPurple,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
