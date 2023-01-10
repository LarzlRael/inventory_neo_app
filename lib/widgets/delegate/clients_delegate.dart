part of 'delegates.dart';

class ClientsDelegate extends SearchDelegate {
  @override
  final String searchFieldLabel;

  ClientsDelegate() : searchFieldLabel = 'Buscar cliente por nombre';
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
      future: query.isEmpty ? getClients() : getClientsWithParameters(query),
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
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: getClients(),
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
            );
          },
        );
      },
    );
  }

  Future<List<ClientModel>> getClientsWithParameters(String parameters) async {
    final clientRequest =
        await getAction('api/client/search/$parameters', useAuxiliarUrl: true);
    return clientModelFromJson(clientRequest!.body);
  }
}
