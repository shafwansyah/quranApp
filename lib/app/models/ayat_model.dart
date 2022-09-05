// To parse this JSON data, do
//
//     final listAyat = listAyatFromJson(jsonString);

import 'dart:convert';

ListAyat listAyatFromJson(String str) => ListAyat.fromJson(json.decode(str));

String listAyatToJson(ListAyat data) => json.encode(data.toJson());

class ListAyat {
  ListAyat({
    this.status,
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
    this.ayat,
    this.suratSelanjutnya,
    this.suratSebelumnya,
  });

  bool? status;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;
  List<Ayat>? ayat;
  Pagination? suratSelanjutnya;
  Pagination? suratSebelumnya;

  factory ListAyat.fromJson(Map<String, dynamic> json) => ListAyat(
        status: json["status"] == null ? null : json["status"],
        nomor: json["nomor"] == null ? null : json["nomor"],
        nama: json["nama"] == null ? null : json["nama"],
        namaLatin: json["nama_latin"] == null ? null : json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"] == null ? null : json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"] == null ? null : json["tempat_turun"],
        arti: json["arti"] == null ? null : json["arti"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        audio: json["audio"] == null ? null : json["audio"],
        ayat: json["ayat"] == null
            ? null
            : List<Ayat>.from(json["ayat"].map((x) => Ayat.fromJson(x))),
        suratSelanjutnya: json["surat_selanjutnya"] == false
            ? null
            : Pagination.fromJson(json["surat_selanjutnya"]),
        suratSebelumnya: json["surat_sebelumnya"] == false
            ? null
            : Pagination.fromJson(json["surat_sebelumnya"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "nomor": nomor == null ? null : nomor,
        "nama": nama == null ? null : nama,
        "nama_latin": namaLatin == null ? null : namaLatin,
        "jumlah_ayat": jumlahAyat == null ? null : jumlahAyat,
        "tempat_turun": tempatTurun == null ? null : tempatTurun,
        "arti": arti == null ? null : arti,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "audio": audio == null ? null : audio,
        "ayat": ayat == null
            ? null
            : List<dynamic>.from(ayat!.map((x) => x.toJson())),
        "surat_selanjutnya":
            suratSelanjutnya == false ? null : suratSelanjutnya!.toJson(),
        "surat_sebelumnya":
            suratSebelumnya == false ? null : suratSebelumnya!.toJson(),
      };
}

class Ayat {
  Ayat({
    this.id,
    this.surah,
    this.nomor,
    this.ar,
    this.tr,
    this.idn,
  });

  int? id;
  int? surah;
  int? nomor;
  String? ar;
  String? tr;
  String? idn;

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        id: json["id"] == null ? null : json["id"],
        surah: json["surah"] == null ? null : json["surah"],
        nomor: json["nomor"] == null ? null : json["nomor"],
        ar: json["ar"] == null ? null : json["ar"],
        tr: json["tr"] == null ? null : json["tr"],
        idn: json["idn"] == null ? null : json["idn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "surah": surah == null ? null : surah,
        "nomor": nomor == null ? null : nomor,
        "ar": ar == null ? null : ar,
        "tr": tr == null ? null : tr,
        "idn": idn == null ? null : idn,
      };
}

class Pagination {
  Pagination({
    this.id,
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  });

  int? id;
  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        id: json["id"] == null ? null : json["id"],
        nomor: json["nomor"] == null ? null : json["nomor"],
        nama: json["nama"] == null ? null : json["nama"],
        namaLatin: json["nama_latin"] == null ? null : json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"] == null ? null : json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"] == null ? null : json["tempat_turun"],
        arti: json["arti"] == null ? null : json["arti"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        audio: json["audio"] == null ? null : json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nomor": nomor == null ? null : nomor,
        "nama": nama == null ? null : nama,
        "nama_latin": namaLatin == null ? null : namaLatin,
        "jumlah_ayat": jumlahAyat == null ? null : jumlahAyat,
        "tempat_turun": tempatTurun == null ? null : tempatTurun,
        "arti": arti == null ? null : arti,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "audio": audio == null ? null : audio,
      };
}
