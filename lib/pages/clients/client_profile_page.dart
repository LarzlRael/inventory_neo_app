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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.black,
            tooltip: 'Editar cliente',
            onPressed: () {
              Navigator.pushNamed(context, 'client_register_page',
                  arguments: ClientData(
                    idClient: clientModel.id,
                    address: clientModel.address1,
                    email: clientModel.email,
                    lastName: clientModel.lastName,
                    name: clientModel.firstName,
                    phone: clientModel.phone,
                  ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.black,
            tooltip: 'Eliminar cliente',
            onPressed: () {
              asyncShowConfirmDialog(
                context,
                'Eliminar',
                '¿Estás seguro de eliminar este cliente?',
                () async {
                  final response = await deleteAction(
                    'api/client/${clientModel.id}',
                    useAuxiliarUrl: true,
                  );

                  if (validateStatus(response!.statusCode)) {
                    GlobalSnackBar.show(
                        context, "Cliente eliminado correctamente",
                        backgroundColor: Colors.green);
                    Navigator.pop(context);
                  } else {
                    GlobalSnackBar.show(context, "Error al eliminar el cliente",
                        backgroundColor: Colors.red);
                  }
                },
              );
            },
          ),
        ],
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
                  CircleAvatar(
                      radius: 75,
                      child: SimpleText(
                        text:
                            "${clientModel.firstName[0]}${clientModel.lastName[0]}"
                                .toUpperCase(),
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        lightThemeColor: Colors.white,
                      )),
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
                    text: clientModel.address1.toCapitalize(),
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
          const TabBar(
            labelColor: Colors.deepPurple,
            tabs: [
              Tab(text: "Cliente"),
              Tab(text: "Compras"),
            ],
          ),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height * 0.6,
            child: TabBarView(
              children: [
                cardContainer('Informacion del cliente', [
                  cardInformation(
                    'Telefono',
                    clientModel.phone,
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone_android_rounded),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          icon: const Icon(Icons.message_rounded),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
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
                    literalDateWithMount(clientModel.createdAt),
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
                    FutureBuilder(
                      future: getOrderByClient(clientModel.email),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<OrdersModel>> snapshot) {
                        if (!snapshot.hasData) {
                          return simpleLoading();
                        }
                        if (snapshot.data!.isEmpty) {
                          return const NoInformation(
                            icon: Icons.shopping_bag_outlined,
                            text: 'Este usuario no ha realizado compras',
                            showButton: false,
                            iconButton: Icons.add,
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SellHistoryCard(
                                order: snapshot.data![index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                    /* const NoInformation(
                      icon: Icons.shopping_bag_outlined,
                      text: 'No hay compras realizadas',
                      showButton: false,
                      iconButton: Icons.add,
                    ), */
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
          padding: const EdgeInsets.all(15.0),
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

  Future<List<OrdersModel>> getOrderByClient(String userEmail) async {
    final response = await getAction(
      'orders?search=$userEmail',
    );

    return ordersModelFromJson(response!.body);
  }
}
