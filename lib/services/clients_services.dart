part of 'services.dart';

class ClientsServices {
  Future<List<ClientModel>> getClients() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'customers',
      {},
      'xd',
    );
    return clientModelFromJson(clientRequest!.body);
  }

  Future<List<ClientModel>> getClientsWithParameters(String parameters) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'customers?search=$parameters',
      {},
      'xd',
    );
    return clientModelFromJson(clientRequest!.body);
  }
}
