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
          Navigator.pushNamed(context, 'client_register_page');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
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
                return Expanded(
                  child: ListView.builder(
                    itemCount: clients?.length,
                    itemBuilder: (_, int index) {
                      return ClientItem(
                        clientModel: clients![index],
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
  final clientRequest = await getAction('customers');
  return clientModelFromJson(clientRequest!.body);
}
