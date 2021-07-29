// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

Countries countriesFromJson(String str) => Countries.fromJson(json.decode(str));

class Countries {
  Countries({
    this.countries,
  });

  List<Country> countries;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    this.nameEn,
  });

  String nameEn;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "name_en": nameEn,
      };
}
