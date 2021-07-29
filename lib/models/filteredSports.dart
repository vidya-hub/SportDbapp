import 'dart:convert';

FilteredLeagues filteredLeaguesFromJson(String str) =>
    FilteredLeagues.fromJson(json.decode(str));

String filteredLeaguesToJson(FilteredLeagues data) =>
    json.encode(data.toJson());

class FilteredLeagues {
  FilteredLeagues({
    this.countrys,
  });

  List<Map<String, String>> countrys;

  factory FilteredLeagues.fromJson(Map<String, dynamic> json) =>
      FilteredLeagues(
        countrys: List<Map<String, String>>.from(json["countrys"].map((x) =>
            Map.from(x).map(
                (k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
      );

  Map<String, dynamic> toJson() => {
        "countrys": List<dynamic>.from(countrys.map((x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
      };
}
