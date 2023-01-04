part of 'models.dart';

// To parse this JSON data, do
//
//     final loginClientModel = loginClientModelFromJson(jsonString);

LoginClientModel loginClientModelFromJson(String str) =>
    LoginClientModel.fromJson(json.decode(str));

String loginClientModelToJson(LoginClientModel data) =>
    json.encode(data.toJson());

class LoginClientModel {
  LoginClientModel({
    required this.client,
    required this.token,
  });

  Client client;
  String token;

  factory LoginClientModel.fromJson(Map<String, dynamic> json) =>
      LoginClientModel(
        client: Client.fromJson(json["client"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "token": token,
      };
}

class Client {
  Client({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.phone,
    required this.email,
    required this.gender,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic firstName;
  String lastName;
  String address1;
  String phone;
  String email;
  dynamic gender;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address1: json["address1"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        password: json["password"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "address1": address1,
        "phone": phone,
        "email": email,
        "gender": gender,
        "password": password,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
