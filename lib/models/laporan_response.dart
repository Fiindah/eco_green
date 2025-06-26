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
  dynamic lokasi;
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

// // To parse this JSON data, do
// //
// //     final laporanResponse = laporanResponseFromJson(jsonString);

// import 'dart:convert';

// LaporanResponse laporanResponseFromJson(String str) =>
//     LaporanResponse.fromJson(json.decode(str));

// String laporanResponseToJson(LaporanResponse data) =>
//     json.encode(data.toJson());

// class LaporanResponse {
//   String? message;
//   Data? data; // Menggunakan Data yang lebih lengkap

//   LaporanResponse({this.message, this.data});

//   factory LaporanResponse.fromJson(Map<String, dynamic> json) =>
//       LaporanResponse(
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
// }

// // ===========================================================================
// // Kelas Data ini SAMA PERSIS dengan kelas Data yang ada di list_laporan_response.dart
// // Ini penting untuk menjaga konsistensi model laporan di seluruh aplikasi.
// // ===========================================================================
// class Data {
//   int? id;
//   int? userId; // Diambil dari list_laporan_response
//   String? judul;
//   String? isi;
//   String? status; // Mengubah dari dynamic menjadi String?
//   DateTime? createdAt; // Mengubah dari String? menjadi DateTime?
//   DateTime? updatedAt; // Mengubah dari String? menjadi DateTime?
//   String? imagePath;
//   String? imageUrl; // Mengubah dari dynamic menjadi String?
//   User? user; // Menambahkan objek User

//   Data({
//     this.id,
//     this.userId,
//     this.judul,
//     this.isi,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.imagePath,
//     this.imageUrl,
//     this.user,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     userId: int.tryParse(json["user_id"].toString()), // Pastikan parsing ke int
//     judul: json["judul"],
//     isi: json["isi"],
//     status: json["status"],
//     createdAt:
//         json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt:
//         json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     imagePath: json["image_path"],
//     imageUrl: json["image_url"],
//     user: json["user"] == null ? null : User.fromJson(json["user"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "judul": judul,
//     "isi": isi,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "image_path": imagePath,
//     "image_url": imageUrl,
//     "user": user?.toJson(),
//   };
// }

// // ===========================================================================
// // Kelas User ini SAMA PERSIS dengan kelas User yang ada di list_laporan_response.dart
// // ===========================================================================
// class User {
//   int? id;
//   String? name;
//   String? email;
//   dynamic
//   emailVerifiedAt; // Tetap dynamic jika tipe dari API bisa bervariasi (null, string tanggal, dll)
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     emailVerifiedAt: json["email_verified_at"],
//     createdAt:
//         json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt:
//         json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "email_verified_at": emailVerifiedAt,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
