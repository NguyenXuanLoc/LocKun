import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  int? id;
  int? categoryId;
  String? name;
  String? poster;
  String? avatar;
  String? houseNumber;
  String? street;
  String? phoneNumber;
  double? latLocation;
  double? lonLocation;
  String? instagramName;
  String? facebookUrl;
  String? description;
  String? otherMedia;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAtAt;
  dynamic providerRules;
  dynamic productions;
  List<Deal>? deals;
  int? openFrom;
  int? openTo;
  int? timeZone;
  String? googleMapUrl;
  bool? active;

  RestaurantModel({
    this.openFrom,
    this.openTo,
    this.timeZone,
    this.deals,
    this.location,
    this.id,
    this.categoryId,
    this.name,
    this.poster,
    this.avatar,
    this.houseNumber,
    this.street,
    this.phoneNumber,
    this.latLocation,
    this.lonLocation,
    this.instagramName,
    this.facebookUrl,
    this.description,
    this.otherMedia,
    this.createdAt,
    this.updatedAtAt,
    this.providerRules,
    this.productions,
    this.googleMapUrl,
    this.active
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        active: json['active'],
        googleMapUrl: json['google_map_url'],
        location: json['location'],
        deals: json["deals"] == null
            ? []
            : List<Deal>.from(json["deals"]!.map((x) => Deal.fromJson(x))),
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        poster: json["poster"],
        avatar: json["avatar"],
        houseNumber: json["house_number"],
        street: json["street"],
        phoneNumber: json["phone_number"],
        latLocation: json["lat_location"]?.toDouble(),
        lonLocation: json["lon_location"]?.toDouble(),
        instagramName: json["instagram_name"],
        facebookUrl: json["facebook_url"],
        description: json["description"],
        otherMedia: json["other_media"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAtAt: json["updated_at_at"] == null
            ? null
            : DateTime.parse(json["updated_at_at"]),
        providerRules: json["ProviderRules"],
        productions: json["Productions"],
        openFrom: json["open_from"] == 0 ? 24*60 : json["open_from"],
        openTo: json["open_to"] == 0 ? 24*60 : json["open_to"],
        timeZone: json["time_zone"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "google_map_url": googleMapUrl,
        "id": id,
        "category_id": categoryId,
        "name": name,
        "poster": poster,
        "avatar": avatar,
        "house_number": houseNumber,
        "street": street,
        "phone_number": phoneNumber,
        "lat_location": latLocation,
        "lon_location": lonLocation,
        "instagram_name": instagramName,
        "facebook_url": facebookUrl,
        "description": description,
        "other_media": otherMedia,
        "created_at": createdAt?.toIso8601String(),
        "updated_at_at": updatedAtAt?.toIso8601String(),
        "ProviderRules": providerRules,
        "Productions": productions,
      };
}

class Deal {
  int? id;
  String? type;
  int? discountNumber;
  String? discountType;
  String? voucherImage;
  dynamic rules;
  int? productId;

  Deal({
    this.id,
    this.type,
    this.discountNumber,
    this.discountType,
    this.voucherImage,
    this.rules,
    this.productId
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
        id: json["id"],
        type: json["type"],
        discountNumber: json["discount_number"],
        discountType: json["discount_type"],
        voucherImage: json["voucher_image"],
        rules: json["rules"],
        productId: json["product_id"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "discount_number": discountNumber,
        "discount_type": discountType,
        "voucher_image": voucherImage,
        "rules": rules,
      };
}
