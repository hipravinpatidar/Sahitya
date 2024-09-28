// To parse this JSON data, do
//
//     final chaptersGita = chaptersGitaFromJson(jsonString);

import 'dart:convert';

ChaptersGita chaptersGitaFromJson(String str) => ChaptersGita.fromJson(json.decode(str));

String chaptersGitaToJson(ChaptersGita data) => json.encode(data.toJson());

class ChaptersGita {
  int status;
  List<MyChapters> data;

  ChaptersGita({
    required this.status,
    required this.data,
  });

  factory ChaptersGita.fromJson(Map<String, dynamic> json) => ChaptersGita(
    status: json["status"],
    data: List<MyChapters>.from(json["data"].map((x) => MyChapters.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MyChapters {
  int id;
  String name;
  String image;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int verseCount;
  String hiName;
  List<Translation> translations;

  MyChapters({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.verseCount,
    required this.hiName,
    required this.translations,
  });

  factory MyChapters.fromJson(Map<String, dynamic> json) => MyChapters(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    verseCount: json["verse_count"],
    hiName: json["hi_name"],
    translations: List<Translation>.from(json["translations"].map((x) => Translation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "verse_count": verseCount,
    "hi_name": hiName,
    "translations": List<dynamic>.from(translations.map((x) => x.toJson())),
  };
}

class Translation {
  TranslationableType translationableType;
  int translationableId;
  Locale locale;
  Key key;
  String value;
  int id;

  Translation({
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
    required this.id,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    translationableType: translationableTypeValues.map[json["translationable_type"]]!,
    translationableId: json["translationable_id"],
    locale: localeValues.map[json["locale"]]!,
    key: keyValues.map[json["key"]]!,
    value: json["value"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "translationable_type": translationableTypeValues.reverse[translationableType],
    "translationable_id": translationableId,
    "locale": localeValues.reverse[locale],
    "key": keyValues.reverse[key],
    "value": value,
    "id": id,
  };
}

enum Key {
  NAME
}

final keyValues = EnumValues({
  "name": Key.NAME
});

enum Locale {
  IN
}

final localeValues = EnumValues({
  "in": Locale.IN
});

enum TranslationableType {
  APP_MODELS_BHAGAVAD_GITA_CHAPTER
}

final translationableTypeValues = EnumValues({
  "App\\Models\\BhagavadGitaChapter": TranslationableType.APP_MODELS_BHAGAVAD_GITA_CHAPTER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
