// To parse this JSON data, do
//
//     final listLaporanResponse = listLaporanResponseFromJson(jsonString);

import 'dart:convert';

ListLaporanResponse listLaporanResponseFromJson(String str) =>
    ListLaporanResponse.fromJson(json.decode(str));

String listLaporanResponseToJson(ListLaporanResponse data) =>
    json.encode(data.toJson());

class ListLaporanResponse {
  String? message;
  List<Data>? data;

  ListLaporanResponse({this.message, this.data});

  factory ListLaporanResponse.fromJson(Map<String, dynamic> json) =>
      ListLaporanResponse(
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Data {
  int? id;
  int? userId; // Mengubah dari String? menjadi int?
  String? judul;
  String? isi;
  String? status;
  DateTime? createdAt; // Mengubah dari String? menjadi DateTime?
  DateTime? updatedAt; // Mengubah dari String? menjadi DateTime?
  // String? imagePath; // Bisa dihapus jika tidak digunakan untuk tampilan daftar
  String? imageUrl;
  String? lokasi;
  User? user;

  Data({
    this.id,
    this.userId,
    this.judul,
    this.isi,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.imagePath,
    this.imageUrl,
    this.lokasi,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: int.tryParse(json["user_id"].toString()), // Pastikan parsing ke int
    judul: json["judul"],
    isi: json["isi"],
    status: json["status"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    // imagePath: json["image_path"],
    imageUrl: json["image_url"],
    lokasi: json["lokasi"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "judul": judul,
    "isi": isi,
    "status": status,
    "created_at": createdAt?.toIso8601String(), // Ubah kembali ke String ISO
    "updated_at": updatedAt?.toIso8601String(), // Ubah kembali ke String ISO
    // "image_path": imagePath,
    "image_url": imageUrl,
    "lokasi": lokasi,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt; // Mengubah dari String? menjadi DateTime?
  DateTime? updatedAt; // Mengubah dari String? menjadi DateTime?

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
