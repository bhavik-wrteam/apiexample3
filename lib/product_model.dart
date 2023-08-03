// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

ProductModel modelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String modelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String message;
  bool error;
  int total;
  List<Datum> data;
  List<Datum> popularCategories;

  ProductModel({
    required this.message,
    required this.error,
    required this.total,
    required this.data,
    required this.popularCategories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    message: json["message"],
    error: json["error"],
    total: json["total"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    popularCategories: List<Datum>.from(json["popular_categories"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "popular_categories": List<dynamic>.from(popularCategories.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String parentId;
  String slug;
  String image;
  String banner;
  String rowOrder;
  String status;
  String clicks;
  List<Datum> children;
  String text;
  StateModel state;
  Icon? icon;
  int level;
  int? total;

  Datum({
    required this.id,
    required this.name,
    required this.parentId,
    required this.slug,
    required this.image,
    required this.banner,
    required this.rowOrder,
    required this.status,
    required this.clicks,
    required this.children,
    required this.text,
    required this.state,
    this.icon,
    required this.level,
    this.total,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    parentId: json["parent_id"],
    slug: json["slug"],
    image: json["image"],
    banner: json["banner"],
    rowOrder: json["row_order"],
    status: json["status"],
    clicks: json["clicks"],
    children: List<Datum>.from(json["children"].map((x) => Datum.fromJson(x))),
    text: json["text"],
    state: StateModel.fromJson(json["state"]),
    //icon: iconValues.map[json["icon"]]!,
    level: json["level"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "parent_id": parentId,
    "slug": slug,
    "image": image,
    "banner": banner,
    "row_order": rowOrder,
    "status": status,
    "clicks": clicks,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
    "text": text,
    "state": state.toJson(),
    "icon": iconValues.reverse[icon],
    "level": level,
    "total": total,
  };
}

enum Icon {
  JSTREE_FOLDER
}

final iconValues = EnumValues({
  "jstree-folder": Icon.JSTREE_FOLDER
});

class StateModel {
  bool opened;

  StateModel({
    required this.opened,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    opened: json["opened"],
  );

  Map<String, dynamic> toJson() => {
    "opened": opened,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
