part of '../pages.dart';

class ClientsPageSelectable extends StatefulWidget {
  const ClientsPageSelectable({super.key});

  @override
  State<ClientsPageSelectable> createState() => _ClientsPageSelectableState();
}

class _ClientsPageSelectableState extends State<ClientsPageSelectable> {
  late CardInventoryProvider cardInventoryProvider;
  late ClientsProvider clientsProvider;
  @override
  void initState() {
    super.initState();
    cardInventoryProvider = context.read<CardInventoryProvider>();
    clientsProvider = context.read<ClientsProvider>();
    clientsProvider.getClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        showTitle: true,
        title: 'Seleccionar cliente',
      ),
      body: SafeArea(
        child: Consumer<ClientsProvider>(
          builder: (_, clientsProvider, __) {
            final clients = clientsProvider.clientesState.clientsList;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (_, int index) {
                  return ClientItem(
                      clientModel: clients[index],
                      clientsProvider: clientsProvider,
                      onTap: () {
                        context.pop();
                        cardInventoryProvider.setClient = clients[index];
                      });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
