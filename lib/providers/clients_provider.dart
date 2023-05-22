part of 'providers.dart';

class ClientsProvider extends ChangeNotifier {
  ClientesState clientesState = ClientesState();

  Future<void> getClients() async {
    clientesState = clientesState.copyWith(isLoading: true);
    final clientRequest = await getAction('client', useAuxiliarUrl: true);
    clientesState = clientesState.copyWith(
      clients: clientsModelFromJson(clientRequest!.body),
      isLoading: false,
    );
    notifyListeners();
  }

  setClientSelected(ClientModel clienteSelected) {
    clientesState = clientesState.copyWith(
      isLoading: true,
      clientSelected: clienteSelected,
    );
    notifyListeners();
  }

  Future<List<ClientModel>> getFetchClients() async {
    clientesState = clientesState.copyWith(isLoading: true);
    final clientRequest = await getAction('client', useAuxiliarUrl: true);
    return clientsModelFromJson(clientRequest!.body);
  }

  Future<bool> addOrEditClient(Map<String, dynamic> clientLike,
      {int? idClient}) async {
    try {
      final response = await (idClient == null
          ? postAction('client', clientLike, useAuxiliarUrl: true)
          : putAction('client/$idClient', clientLike, useAuxiliarUrl: true));

      final clientRequest = clientModelFromJson(response!.body);

      if (idClient == null) {
        clientesState = clientesState.copyWith(
          clients: [...clientesState.clientsList, clientRequest],
        );
      }
      clientesState = clientesState.copyWith(
        clientSelected: clientRequest,
        clients: clientesState.clientsList
            .map((element) => element.id == idClient ? clientRequest : element)
            .toList(),
      );

      notifyListeners();
      return validateStatus(response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteClient(
    int idClient,
  ) async {
    try {
      final clientRequest = await Request.sendRequestWithToken(
        RequestType.delete,
        'client/$idClient',
        useAuxiliarUrl: true,
        {},
      );
      if (!validateStatus(clientRequest!.statusCode)) {
        throw Exception('Error al eliminar el cliente');
      }
      clientesState = clientesState.copyWith(
        clients: clientesState.clientsList
            .where((element) => element.id != idClient)
            .toList(),
      );
      notifyListeners();
      return validateStatus(clientRequest.statusCode);
    } catch (e) {
      return false;
    }
  }

  Future<List<ClientModel>> getClientsWithParameters(String parameters) async {
    final clientRequest =
        await getAction('client/search/$parameters', useAuxiliarUrl: true);
    return clientsModelFromJson(clientRequest!.body);
  }

  Future<void> getClient(int idClient) async {
    final clientRequest = await getAction(
      'client/$idClient',
      useAuxiliarUrl: true,
    );
    clientesState = clientesState.copyWith(
      clientSelected: clientModelFromJson(clientRequest!.body),
    );
  }
}

class ClientesState {
  final ClientModel? clientSelected;
  final bool isLoading;
  final List<ClientModel> clientsList;
  ClientesState({
    this.isLoading = false,
    this.clientsList = const [],
    this.clientSelected,
  });
  ClientesState copyWith({
    bool? isLoading,
    List<ClientModel>? clients,
    ClientModel? clientSelected,
  }) =>
      ClientesState(
        isLoading: isLoading ?? this.isLoading,
        clientsList: clients ?? this.clientsList,
        clientSelected: clientSelected ?? this.clientSelected,
      );
}
