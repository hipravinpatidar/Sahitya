// To parse this JSON data, do
//
//     final tabModel = tabModelFromJson(jsonString);

import 'dart:convert';

TabModel tabModelFromJson(String str) => TabModel.fromJson(json.decode(str));

String tabModelToJson(TabModel data) => json.encode(data.toJson());

class TabModel {
  int status;
  List<TabsName> data;

  TabModel({
    required this.status,
    required this.data,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) => TabModel(
    status: json["status"],
    data: List<TabsName>.from(json["data"].map((x) => TabsName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TabsName {
  int id;
  String enName;
  String hiName;
  String image;

  TabsName({
    required this.id,
    required this.enName,
    required this.hiName,
    required this.image,
  });

  factory TabsName.fromJson(Map<String, dynamic> json) => TabsName(
    id: json["id"],
    enName: json["en_name"],
    hiName: json["hi_name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "en_name": enName,
    "hi_name": hiName,
    "image": image,
  };
}
