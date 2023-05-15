/* const baseURL = 'https://subastareas2.herokuapp.com'; */
import 'package:flutter_dotenv/flutter_dotenv.dart';

const baseURL = 'https://arrieta.exon.vip/wp-json/wc/v3';

const serverHttpUrl = baseURL;

class Enviroment {
  static initEnviroment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
