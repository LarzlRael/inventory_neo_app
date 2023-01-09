part of 'utils.dart';

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalize())
      .join(' ');
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

bool validateStatus(int? state) {
  const status = [200, 201, 202, 203, 204];
  return status.contains(state);
}

Future<String> getToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'token') ?? '';
}
