// To parse this JSON data, do
//
//     final ShlokModel = ShlokModelFromJson(jsonString);

import 'dart:convert';

ShlokModel ShlokModelFromJson(String str) => ShlokModel.fromJson(json.decode(str));

String ShlokModelToJson(ShlokModel data) => json.encode(data.toJson());

class ShlokModel {
  int? status;
  List<Chapters>? data;

  ShlokModel({
    required this.status,
    required this.data,
  });

  factory ShlokModel.fromJson(Map<String, dynamic> json) => ShlokModel(
    status: json["status"] ?? 0, // default to 0 if "status" is null
    data: json["data"] != null
        ? List<Chapters>.from(json["data"].map((x) => Chapters.fromJson(x)))
        : [], // default to empty list if "data" is null
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.map((x) => x.toJson()),
  };
}

class Chapters {
  int? chapter;
  String? chapterName;
  String? hiChapterName;
  String? chapterImage;
  List<Verse>? verses;

  Chapters({
    required this.chapter,
    required this.chapterName,
    required this.hiChapterName,
    required this.chapterImage,
    required this.verses,
  });

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
    chapter: json["chapter"] ?? 0, // default to 0 if "chapter" is null
    chapterName: json["chapter_name"] ?? "", // default to empty string if "chapter_name" is null
    hiChapterName: json["hi_chapter_name"] ?? "", // default to empty string if "hi_chapter_name" is null
    chapterImage: json["chapter_image"] ?? "", // default to empty string if "chapter_image" is null
    verses: json["verses"] != null
        ? List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x)))
        : [], // default to empty list if "verses" is null
  );

  Map<String, dynamic> toJson() => {
    "chapter": chapter,
    "chapter_name": chapterName,
    "hi_chapter_name": hiChapterName,
    "chapter_image": chapterImage,
    "verses": verses?.map((x) => x.toJson()),
  };
}

class Verse {
  int? verse;
  String? description;
  String? hiDescription;
  String? verseImage;
  VerseData? verseData;

  Verse({
    required this.verse,
    required this.description,
    required this.hiDescription,
    required this.verseImage,
    required this.verseData,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    verse: json["verse"] ?? 0, // default to 0 if "verse" is null
    description: json["description"] ?? "", // default to empty string if "description" is null
    hiDescription: json["hi_description"] ?? "", // default to empty string if "hi_description" is null
    verseImage: json["verse_image"] ?? "", // default to empty string if "verse_image" is null
    verseData: json["verse_data"] != null ? VerseData.fromJson(json["verse_data"]) : null, // default to null if "verse_data" is null
  );

  Map<String, dynamic> toJson() => {
    "verse": verse,
    "description": description,
    "hi_description": hiDescription,
    "verse_image": verseImage,
    "verse_data": verseData?.toJson(),
  };
}

class VerseData {
  VerseDataClass? verseData;
  String? audioUrl;
  String? message;

  VerseData({
    this.verseData,
    this.audioUrl,
    this.message,
  });

  factory VerseData.fromJson(Map<String, dynamic> json) => VerseData(
    verseData: json["verseData"] != null ? VerseDataClass.fromJson(json["verseData"]) : null, // default to null if "verseData" is null
    audioUrl: json["audioUrl"] ?? "", // default to empty string if "audioUrl" is null
    message: json["message"] ?? "", // default to empty string if "message" is null
  );

  Map<String, dynamic> toJson() => {
    "verseData": verseData?.toJson(),
    "audioUrl": audioUrl,
    "message": message,
  };
}

class VerseDataClass {
  String? sanskrit;
  String? hindi;
  String? english;
  String? bangla;
  String? assamese;
  String? gujrati;
  String? marathi;
  String? punjabi;
  String? maithili;
  String? kannada;
  String? malayalam;
  String? tamil;
  String? telugu;

  VerseDataClass({
    this.sanskrit,
    this.hindi,
    this.english,
    this.bangla,
    this.assamese,
    this.gujrati,
    this.marathi,
    this.punjabi,
    this.maithili,
    this.kannada,
    this.malayalam,
    this.tamil,
    this.telugu,
  });

  factory VerseDataClass.fromJson(Map<String, dynamic> json) =>
      VerseDataClass(
        sanskrit: json["sanskrit"] ?? "",
        // default to empty string if "sanskrit" is null
        hindi: json["hindi"] ?? "",
        // default to empty string if "hindi" is null
        english: json["english"] ?? "",
        // default to empty string if "english" is null
        bangla: json["bangla"] ?? "",
        // default to empty string if "bangla" is null
        assamese: json["assamese"] ?? "",
        // default to empty string if "assamese" is null
        gujrati: json["gujrati"] ?? "",
        // default to empty string if "gujrati" is null
        marathi: json["marathi"] ?? "",
        // default to empty string if "marathi" is null
        punjabi: json["punjabi"] ?? "",
        // default to empty string if "punjabi" is null
        maithili: json["maithili"] ?? "",
        // default to empty string if "maithili" is null
        kannada: json["kannada"] ?? "",
        // default to empty string if "kannada" is null
        malayalam: json["malayalam"] ?? "",
        // default to empty string if "malayalam" is null
        tamil: json["tamil"] ?? "",
        // default to empty string if "tamil" is null
        telugu: json["telugu"] ??
            "", // default to empty string if "telugu" is null
      );

  Map<String, dynamic> toJson() =>
      {
        "sanskrit": sanskrit,
        "hindi": hindi,
        "english": english,
        "bangla": bangla,
        "assamese": assamese,
        "gujrati": gujrati,
        "marathi": marathi,
        "punjabi": punjabi,
        "maithili": maithili,
        "kannada": kannada,
        "malayalam": malayalam,
        "tamil": tamil,
        "telugu": telugu,
      };
}