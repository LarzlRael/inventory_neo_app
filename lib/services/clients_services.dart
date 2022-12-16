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

  Future<bool> addClient(Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'customers',
      body,
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }

  Future<bool> editClient(int idClient, Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.put,
      'customers/$idClient',
      body,
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }

  Future<bool> deleteClient(
    int idClient,
  ) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.delete,
      'customers/$idClient',
      {},
      'xd',
    );
    return validateStatus(clientRequest!.statusCode);
  }
}
