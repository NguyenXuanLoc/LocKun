import 'package:base_bloc/data/model/restaurant_model.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PlaceType { FOOD, BARS, RESTAURANT, CAFES }

extension PlaceTypeStr on PlaceType {
  int get type {
    switch (this) {
      case PlaceType.FOOD:
        return 4;
      case PlaceType.BARS:
        return 7;
      case PlaceType.RESTAURANT:
        return 3;
      case PlaceType.CAFES:
        return 1;
    }
  }
}

PlaceType fromInt(int category) {
  final map = {
    PlaceType.FOOD: 4,
    PlaceType.BARS: 7,
    PlaceType.RESTAURANT: 3,
    PlaceType.CAFES: 1
  }.map<int, PlaceType>((key, value) => MapEntry(value, key));
  PlaceType? output = map[category];
  if (output == null) return PlaceType.FOOD;
  return output;
}

class PlaceModel with ClusterItem {
  final String name;
  LatLng latLng;

  final PlaceType type;
  int? id;
  int? categoryId;
  String? poster;
  String? avatar;
  String? locationStr;
  List<Deal>? deals;
  String? distance;
  bool isOpen;
  int? openTo;
  int? openFrom;
  int? timeZone;
  bool? active;

  PlaceModel(
      {this.deals,
      this.active,
      this.openTo,
      this.openFrom,
      this.timeZone,
      this.isOpen = true,
      required this.type,
      required this.name,
      required this.latLng,
      this.id,
      this.categoryId,
      this.poster,
      this.avatar,
      this.locationStr,
      this.distance});

  PlaceModel copyOf(
          {int? openTo,
          int? openFrom,
          bool? active,
          int? timeZone,
          String? name,
          LatLng? latLng,
          bool? isOpen,
          PlaceType? type,
          int? id,
          int? categoryId,
          String? poster,
          String? avatar,
          String? houseNumber,
          String? street,
          String? phoneNumber,
          String? locationStr,
          String? instagramName,
          String? description,
          String? otherMedia,
          int? dealsCount,
          List<Deal>? deals,
          String? facebookUrl,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? groupSize,
          String? distance}) =>
      PlaceModel(
        active: active ?? this.active,
        openFrom: openFrom ?? this.openFrom,
        openTo: openTo ?? this.openTo,
        timeZone: timeZone ?? this.timeZone,
        isOpen: isOpen ?? this.isOpen,
        distance: distance ?? this.distance,
        name: name ?? this.name,
        latLng: latLng ?? this.latLng,
        type: type ?? this.type,
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        poster: poster ?? this.poster,
        avatar: avatar ?? this.avatar,
        deals: deals ?? this.deals,
        locationStr: locationStr ?? this.locationStr,
      );

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      PlaceModel(
        active: json["active"],
        openTo: json['open_to'] == 0 ? 24 * 60 : json['open_to'],
        timeZone: json['time_zone'],
        openFrom: json['open_from'] == 0 ? 24 * 60 : json['open_from'],
        deals: json["deals"] == null
            ? []
            : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
        type: fromInt(json["category_id"] ?? 1),
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        poster: json["poster"],
        avatar: json["avatar"],
        locationStr: json["location"],
        latLng: json["location"] != null
            ? LatLng(double.parse((json["location"] ?? '').split(',').first),
                double.parse((json["location"] ?? '').split(',').last))
            : const LatLng(0, 0),
      );

  @override
  String toString() {
    return 'Place $name (closed)';
  }

  Map<String, dynamic> toJson() => {
        "active": active,
        "open_to": openTo,
        "time_zone": timeZone,
        "open_from": openFrom,
        "deals": List<dynamic>.from(deals!.map((x) => x.toJson())),
        "id": id,
        "category_id": categoryId,
        "name": name,
        "poster": poster,
        "avatar": avatar,
        "locationStr": locationStr,
      };

  @override
  LatLng get location => LatLng(
      double.parse((locationStr ?? '').split(',').first),
      double.parse((locationStr ?? '').split(',').last));
}
