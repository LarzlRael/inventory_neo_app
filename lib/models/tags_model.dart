part of 'models.dart';

List<TagsModel> tagsModelFromJson(String str) =>
    List<TagsModel>.from(json.decode(str).map((x) => TagsModel.fromJson(x)));

String tagsModelToJson(List<TagsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
TagsModel tagModelFromJson(String str) => TagsModel.fromJson(json.decode(str));

class TagsModel {
  TagsModel({
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

  factory TagsModel.fromJson(Map<String, dynamic> json) => TagsModel(
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
