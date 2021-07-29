import 'dart:convert';

AllSports allSportsFromJson(String str) => AllSports.fromJson(json.decode(str));

String allSportsToJson(AllSports data) => json.encode(data.toJson());

class AllSports {
  AllSports({
    this.sports,
  });

  List<Sport> sports;

  factory AllSports.fromJson(Map<String, dynamic> json) => AllSports(
        sports: List<Sport>.from(json["sports"].map((x) => Sport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sports": List<dynamic>.from(sports.map((x) => x.toJson())),
      };
}

class Sport {
  Sport({
    this.idSport,
    this.strSport,
    this.strFormat,
    this.strSportThumb,
    this.strSportThumbGreen,
    this.strSportDescription,
  });

  String idSport;
  String strSport;
  StrFormat strFormat;
  String strSportThumb;
  String strSportThumbGreen;
  String strSportDescription;

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        idSport: json["idSport"],
        strSport: json["strSport"],
        strFormat: strFormatValues.map[json["strFormat"]],
        strSportThumb:
            json["strSportThumb"] == null ? null : json["strSportThumb"],
        strSportThumbGreen: json["strSportThumbGreen"],
        strSportDescription: json["strSportDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idSport": idSport,
        "strSport": strSport,
        "strFormat": strFormatValues.reverse[strFormat],
        "strSportThumb": strSportThumb == null ? null : strSportThumb,
        "strSportThumbGreen": strSportThumbGreen,
        "strSportDescription": strSportDescription,
      };
}

enum StrFormat { TEAMVS_TEAM, EVENT_SPORT }

final strFormatValues = EnumValues(
    {"EventSport": StrFormat.EVENT_SPORT, "TeamvsTeam": StrFormat.TEAMVS_TEAM});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
