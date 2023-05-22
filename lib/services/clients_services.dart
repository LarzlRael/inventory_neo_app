/* part of 'services.dart';

class ClientsServices {
  Future<List<ClientModel>> getClients() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'customers',
      {},
    );
    return clientsModelFromJson(clientRequest!.body);
  }

  Future<List<ClientModel>> getClientsWithParameters(String parameters) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'customers?search=$parameters',
      {},
    );
    return clientsModelFromJson(clientRequest!.body);
  }

  Future<bool> addClient(Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.post,
      'customers',
      body,
    );
    return validateStatus(clientRequest!.statusCode);
  }

  Future<bool> editClient(int idClient, Map<String, dynamic> body) async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.put,
      'customers/$idClient',
      body,
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
    );
    return validateStatus(clientRequest!.statusCode);
  }

  Future<ClientModel> addOrEditClient(Map<String, dynamic> clientLike,
      {int? idClient}) async {
    try {
      final response = await (idClient == null
          ? postAction('api/client', clientLike, useAuxiliarUrl: true)
          : putAction('api/client/$idClient', clientLike,
              useAuxiliarUrl: true));

      return clientModelFromJson(response!.body);
    } catch (e) {
      rethrow;
    }
  }
}
 */
