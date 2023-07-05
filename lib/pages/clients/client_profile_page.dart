part of '../pages.dart';

class ClientProfilePage extends StatefulWidget {
  final int idClient;
  const ClientProfilePage({
    super.key,
    required this.idClient,
  });

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  late ClientsProvider clientsProvider;
  late GlobalProvider globalProvider;
  @override
  void initState() {
    super.initState();
    clientsProvider = context.read<ClientsProvider>();
    globalProvider = context.read<GlobalProvider>();
    clientsProvider.getClient(widget.idClient);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClientsProvider>(builder: (_, clientsProvider, __) {
      final clienteSeleccionado = clientsProvider.clientesState.clientSelected;
      return Scaffold(
        appBar: AppBarWithBackIcon(
          appBar: AppBar(),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.black,
              tooltip: 'Editar cliente',
              onPressed: () {
                context.push(
                  '/client_register_page',
                  extra: clienteSeleccionado,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.black,
              tooltip: 'Eliminar cliente',
              onPressed: () {
                asyncShowConfirmDialog(context, 'Eliminar',
                    '¿Estás seguro de eliminar este cliente?', () async {
                  clientsProvider
                      .deleteClient(clienteSeleccionado!.id!)
                      .then((value) {
                    if (value) {
                      globalProvider.showSnackBar(
                        context,
                        "Cliente eliminado correctamente",
                        backgroundColor: Colors.green,
                      );
                      context.pop();
                    } else {
                      globalProvider.showSnackBar(
                        context,
                        "Error al eliminar el cliente",
                        backgroundColor: Colors.red,
                      );
                    }
                  });
                });
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
                        radius: 60,
                        child: SimpleText(
                          text:
                              "${clienteSeleccionado!.firstName[0]}${clienteSeleccionado.lastName[0]}"
                                  .toUpperCase(),
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        )),
                    SimpleText(
                      text:
                          '${clienteSeleccionado.firstName} ${clienteSeleccionado.lastName}'
                              .toTitleCase(),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      color: Colors.white,
                    ),
                    SimpleText(
                      text: clienteSeleccionado.address1.toCapitalize(),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              _tabSection(context),
            ],
          ),
        ),
      );
    });
  }

  Widget _tabSection(
    BuildContext context,
  ) {
    final orderProvider = context.read<OrderProvider>();
    final clientModel =
        context.read<ClientsProvider>().clientesState.clientSelected!;
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
                      future: orderProvider.getOrderByClient(clientModel.email),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<OrderModel>> snapshot) {
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
                color: Colors.black26,
              ),
              SimpleText(
                padding: const EdgeInsets.only(top: 3),
                text: value,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
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
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                color: Colors.deepPurple,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
