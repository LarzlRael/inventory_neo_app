part of 'models.dart';

// To parse this JSON data, do
//
//     final newProductoModel = newProductoModelFromJson(jsonString);

NewProductoModel newProductoModelFromJson(String str) =>
    NewProductoModel.fromJson(json.decode(str));

String newProductoModelToJson(NewProductoModel data) =>
    json.encode(data.toJson());

class NewProductoModel {
  NewProductoModel({
    required this.name,
    required this.type,
    required this.regularPrice,
    required this.description,
    required this.categories,
    required this.tags,
  });

  String name;
  String type;
  String regularPrice;
  String description;
  List<CategoryNewProduct> categories;
  List<CategoryNewProduct> tags;

  factory NewProductoModel.fromJson(Map<String, dynamic> json) =>
      NewProductoModel(
        name: json["name"],
        type: json["type"],
        regularPrice: json["regular_price"],
        description: json["description"],
        categories: List<CategoryNewProduct>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags: List<CategoryNewProduct>.from(
            json["tags"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "regular_price": regularPrice,
        "description": description,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}

class CategoryNewProduct {
  CategoryNewProduct({
    required this.id,
  });

  int id;

  factory CategoryNewProduct.fromJson(Map<String, dynamic> json) =>
      CategoryNewProduct(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
