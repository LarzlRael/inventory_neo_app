part of '../pages.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    /* final clientsService = ClientsServices(); */

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar cliente',
        onPressed: () {
          context.push('/client_register_page');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Clientes',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                context: context,
                delegate: ClientsDelegate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
              future: getClients(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ClientModel>> snapshot) {
                if (!snapshot.hasData) {
                  return simpleLoading();
                }
                final clients = snapshot.data;
                if (clients!.isEmpty) {
                  return const Expanded(
                    child: NoInformation(
                      text: 'No hay clientes registrados',
                      icon: Icons.person,
                      iconButton: Icons.person,
                      showButton: false,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: clients.length,
                    itemBuilder: (_, int index) {
                      return ClientItem(
                        clientModel: clients[index],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<ClientModel>> getClients() async {
  final clientRequest = await getAction('api/client', useAuxiliarUrl: true);
  return clientModelFromJson(clientRequest!.body);
}
