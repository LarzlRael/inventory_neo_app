part of 'models.dart';

List<ClientModel> clientsModelFromJson(String str) => List<ClientModel>.from(
    json.decode(str).map((x) => ClientModel.fromJson(x)));

String clientsModelToJson(List<ClientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ClientModel clientModelFromJson(String str) =>
    ClientModel.fromJson(json.decode(str));

String clientModelToJson(ClientModel data) => json.encode(data.toJson());

class ClientModel {
  ClientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address1,
    required this.phone,
    required this.email,
    required this.gender,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String firstName;
  String lastName;
  String address1;
  String phone;
  String email;
  dynamic gender;
  DateTime createdAt;
  DateTime updatedAt;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address1: json["address1"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
