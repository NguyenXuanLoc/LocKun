// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(List<dynamic> str) => List<CategoryModel>.from(str.map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAtAt;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAtAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAtAt: json["updated_at_at"] == null ? null : DateTime.parse(json["updated_at_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at_at": updatedAtAt?.toIso8601String(),
  };
}
