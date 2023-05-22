part of 'providers.dart';

class ClientsProvider extends ChangeNotifier {
  ClientesState clientesState = ClientesState();

  Future<void> getClients() async {
    clientesState = clientesState.copyWith(isLoading: true);
    final clientRequest = await getAction('/client', useAuxiliarUrl: true);
    clientesState = clientesState.copyWith(
      clients: clientsModelFromJson(clientRequest!.body),
      isLoading: false,
    );
    notifyListeners();
  }

  Future<List<ClientModel>> getFetchClients() async {
    clientesState = clientesState.copyWith(isLoading: true);
    final clientRequest = await getAction('/client', useAuxiliarUrl: true);
    return clientsModelFromJson(clientRequest!.body);
  }

  Future<void> addOrEditClient(Map<String, dynamic> clientLike,
      {int? idClient}) async {
    try {
      final response = await (idClient == null
          ? postAction('/client', clientLike, useAuxiliarUrl: true)
          : putAction('/client/$idClient', clientLike, useAuxiliarUrl: true));

      clientesState = clientesState.copyWith(
        clients: [
          ...clientesState.clientsList,
          clientModelFromJson(response!.body)
        ],
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteClient(
    int idClient,
  ) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.delete,
      '/customers/$idClient',
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
  }

  Future<List<ClientModel>> getClientsWithParameters(String parameters) async {
    final clientRequest =
        await getAction('/client/search/$parameters', useAuxiliarUrl: true);
    return clientsModelFromJson(clientRequest!.body);
  }
}

class ClientesState {
  final bool isLoading;
  final List<ClientModel> clientsList;
  ClientesState({
    this.isLoading = false,
    this.clientsList = const [],
  });
  ClientesState copyWith({
    bool? isLoading,
    List<ClientModel>? clients,
  }) =>
      ClientesState(
        isLoading: isLoading ?? this.isLoading,
        clientsList: clients ?? this.clientsList,
      );
}
