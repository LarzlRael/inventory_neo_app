part of 'models.dart';

List<TagModel> tagsModelFromJson(String str) =>
    List<TagModel>.from(json.decode(str).map((x) => TagModel.fromJson(x)));

String tagsModelToJson(List<TagModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String tagModelToJson(TagModel data) => json.encode(data.toJson());

TagModel tagModelFromJson(String str) => TagModel.fromJson(json.decode(str));

class TagModel {
  TagModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.count,
    required this.links,
  });

  int id;
  String name;
  String slug;
  String description;
  int count;
  Links links;

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        count: json["count"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "count": count,
        "_links": links.toJson(),
      };
}
