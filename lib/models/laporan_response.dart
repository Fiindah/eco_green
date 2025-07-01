// To parse this JSON data, do
//
//     final laporanResponse = laporanResponseFromJson(jsonString);

import 'dart:convert';

LaporanResponse laporanResponseFromJson(String str) =>
    LaporanResponse.fromJson(json.decode(str));

String laporanResponseToJson(LaporanResponse data) =>
    json.encode(data.toJson());

class LaporanResponse {
  String? message;
  Data? data;

  LaporanResponse({this.message, this.data});

  factory LaporanResponse.fromJson(Map<String, dynamic> json) =>
      LaporanResponse(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  int? id;
  String? judul;
  String? isi;
  String? lokasi;
  dynamic status;
  String? imageUrl;
  String? imagePath;

  Data({
    this.id,
    this.judul,
    this.isi,
    this.lokasi,
    this.status,
    this.imageUrl,
    this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    judul: json["judul"],
    isi: json["isi"],
    lokasi: json["lokasi"],
    status: json["status"],
    imageUrl: json["image_url"],
    imagePath: json["image_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "isi": isi,
    "lokasi": lokasi,
    "status": status,
    "image_url": imageUrl,
    "image_path": imagePath,
  };
}
