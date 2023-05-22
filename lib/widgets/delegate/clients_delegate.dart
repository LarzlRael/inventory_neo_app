part of 'delegates.dart';

class ClientsDelegate extends SearchDelegate {
  final ClientsProvider clientsProvider;
  @override
  final String searchFieldLabel;

  ClientsDelegate({required this.clientsProvider})
      : searchFieldLabel = 'Buscar cliente por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.clear,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: query.isEmpty
          ? clientsProvider.getFetchClients()
          : clientsProvider.getClientsWithParameters(query),
      builder: (_, AsyncSnapshot<List<ClientModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        final clients = snapshot.data;
        if (clients!.isEmpty) {
          return Expanded(
            child: NoInformation(
              text: 'No se encontraron resutados para "$query"',
              icon: Icons.person,
              iconButton: Icons.person,
              showButton: false,
            ),
          );
        }

        return ListView.builder(
          itemCount: clients.length,
          itemBuilder: (BuildContext context, int index) {
            return ClientItem(
              clientModel: clients[index],
              clientsProvider: clientsProvider,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: clientsProvider.getFetchClients(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ClientModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        final clients = snapshot.data;
        return ListView.builder(
          itemCount: clients?.length,
          itemBuilder: (BuildContext context, int index) {
            return ClientItem(
              clientModel: clients![index],
              clientsProvider: clientsProvider,
            );
          },
        );
      },
    );
  }
}
