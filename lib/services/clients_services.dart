import 'package:inventory_app/models/models.dart';
import 'package:inventory_app/services/services.dart';

class ClientsServices {
  Future<List<ClientModel>> getClients() async {
    final clientRequest = await Request.sendRequestWithToken(
      RequestType.get,
      'clients',
      {},
      'xd',
    );
    return clientModelFromJson(clientRequest!.body);
  }
}
