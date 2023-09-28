import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  final int id;
  final String title;
  final String image;
  final String parent;
  final int childrenCount;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.parent,
    required this.childrenCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        parent: json["parent"],
        childrenCount: json["children_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "parent": parent,
        "children_count": childrenCount,
      };
}
