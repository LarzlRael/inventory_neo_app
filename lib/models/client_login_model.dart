part of 'models.dart';

// To parse this JSON data, do
//
//     final loginClientModel = loginClientModelFromJson(jsonString);

LoginClientModel? loginClientModelFromJson(String str) =>
    LoginClientModel.fromJson(json.decode(str));

String loginClientModelToJson(LoginClientModel? data) =>
    json.encode(data!.toJson());

class LoginClientModel {
  LoginClientModel({
    this.client,
    this.token,
  });

  Client? client;
  String? token;

  factory LoginClientModel.fromJson(Map<String, dynamic> json) =>
      LoginClientModel(
        client: Client.fromJson(json["client"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "client": client!.toJson(),
        "token": token,
      };
}

class Client {
  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.address1,
    this.phone,
    this.email,
    this.gender,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.storeId,
    this.store,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? address1;
  String? phone;
  String? email;
  dynamic gender;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? storeId;
  Store? store;

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
        storeId: json["storeId"],
        store: Store.fromJson(json["store"]),
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "storeId": storeId,
        "store": store!.toJson(),
      };
}

class Store {
  Store({
    this.id,
    this.name,
    this.direction,
    this.typeStore,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? direction;
  String? typeStore;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        direction: json["direction"],
        typeStore: json["type_store"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "direction": direction,
        "type_store": typeStore,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
