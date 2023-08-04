part of '../pages.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late ClientsProvider clientsProvider;
  @override
  void initState() {
    super.initState();
    clientsProvider = context.read<ClientsProvider>();
    clientsProvider.getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Agregar cliente'),
          tooltip: 'Agregar cliente',
          onPressed: () {
            context.push('/client_register_page');
          },
          icon: const Icon(Icons.add)),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Clientes',
        showTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                context: context,
                delegate: ClientsDelegate(
                  clientsProvider: clientsProvider,
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ClientsProvider>(builder: (_, clientsProvider, __) {
        final clients = clientsProvider.clientesState.clientsList;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            itemCount: clients.length,
            itemBuilder: (_, int index) {
              return ClientItem(
                onSelected: (clientModel) {
                  context.push(
                    '/client_profile',
                    extra: clientModel.id,
                  );
                },
                clientModel: clients[index],
                clientsProvider: clientsProvider,
              );
            },
          ),
        );
      }),
    );
  }
}
