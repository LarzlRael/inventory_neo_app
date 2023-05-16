/* const baseURL = 'https://subastareas2.herokuapp.com'; */
import 'package:flutter_dotenv/flutter_dotenv.dart';

/* const serverHttpUrl = baseURL; */

class Environment {
  static initEnviroment() async {
    await dotenv.load(
      fileName: '.env',
    );
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
  static String baseURL =
      dotenv.env['WOOCOMMERCE_API_URL'] ?? 'No está configurado el API_URL';
  /* static String serverHttpUrl =
      dotenv.env['WOOCOMMERCE_API_URL'] ?? 'No está configurado el API_URL'; */
}
