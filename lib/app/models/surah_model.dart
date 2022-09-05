// To parse this JSON data, do
//
//     final listSurah = listSurahFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ListSurah> listSurahFromJson(String str) =>
    List<ListSurah>.from(json.decode(str).map((x) => ListSurah.fromJson(x)));

String listSurahToJson(List<ListSurah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListSurah {
  ListSurah({
    this.nomor,
    this.nama,
    this.namaLatin,
    this.jumlahAyat,
    this.tempatTurun,
    this.arti,
    this.deskripsi,
    this.audio,
  });

  int? nomor;
  String? nama;
  String? namaLatin;
  int? jumlahAyat;
  String? tempatTurun;
  String? arti;
  String? deskripsi;
  String? audio;

  factory ListSurah.fromJson(Map<String, dynamic> json) => ListSurah(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["nama_latin"],
        jumlahAyat: json["jumlah_ayat"],
        tempatTurun: json["tempat_turun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "nomor": nomor,
        "nama": nama,
        "nama_latin": namaLatin,
        "jumlah_ayat": jumlahAyat,
        "tempat_turun": tempatTurun,
        "arti": arti,
        "deskripsi": deskripsi,
        "audio": audio,
      };
}
