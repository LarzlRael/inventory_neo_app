part of 'models.dart';

List<CategorieModel> categoriesModelFromJson(String str) =>
    List<CategorieModel>.from(
        json.decode(str).map((x) => CategorieModel.fromJson(x)));

String categoriesModelToJson(List<CategorieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CategorieModel categoryModelFromJson(String str) =>
    CategorieModel.fromJson(json.decode(str));

String categoryModelToJson(CategorieModel data) => json.encode(data.toJson());

class CategorieModel {
  CategorieModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.parent,
    required this.description,
    required this.display,
    required this.image,
    required this.menuOrder,
    required this.count,
    required this.links,
  });

  int id;
  String name;
  String slug;
  int parent;
  String description;
  String display;
  ImageClass? image;
  int menuOrder;
  int count;
  LinksCategories links;

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        parent: json["parent"],
        description: json["description"],
        display: json["display"],
        image:
            json["image"] == null ? null : ImageClass.fromJson(json["image"]),
        menuOrder: json["menu_order"],
        count: json["count"],
        links: LinksCategories.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "parent": parent,
        "description": description,
        "display": display,
        "image": image,
        "menu_order": menuOrder,
        "count": count,
        "_links": links.toJson(),
      };
}

class ImageClass {
  ImageClass({
    required this.id,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.src,
    required this.name,
    required this.alt,
  });

  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String src;
  String name;
  String alt;

  factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        /* TODO change this 
        src: json["src"],
        */
        src:
            'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930',
        name: json["name"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "src": src,
        "name": name,
        "alt": alt,
      };
}

class LinksCategories {
  LinksCategories({
    required this.self,
    required this.collection,
    required this.up,
  });

  List<Collection> self;
  List<Collection> collection;
  List<Collection>? up;

  factory LinksCategories.fromJson(Map<String, dynamic> json) =>
      LinksCategories(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        up: json["up"] == null
            ? null
            : List<Collection>.from(
                json["up"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "up":
            up == null ? null : List<dynamic>.from(up!.map((x) => x.toJson())),
      };
}

class Ing {
  Ing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
    /* required this.email, */
    required this.phone,
  });

  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  /* String email; */
  String phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        postcode: json["postcode"],
        country: json["country"],
        state: json["state"],
        /* email: json["email"] == null ? null : json["email"], */
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "postcode": postcode,
        "country": country,
        "state": state,
        /* "email": email == null ? null : email, */
        "phone": phone,
      };
}

class Links {
  Links({
    required this.self,
    required this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    required this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}
