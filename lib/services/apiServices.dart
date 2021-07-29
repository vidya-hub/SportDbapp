import 'package:http/http.dart' as http;
import 'package:teamwaveapp/models/allSports.dart';
import 'package:teamwaveapp/models/countries.dart';
import 'package:teamwaveapp/models/filteredSports.dart';
import 'package:teamwaveapp/models/sportsList.dart';

class ApiService {
  http.Response response;
  static Future<Countries> getCountries() async {
    String url = "https://www.thesportsdb.com/api/v1/json/1/all_countries.php";
    var response = await http.get(Uri.parse(url));
    return countriesFromJson(response.body);
  }

  static Future<AllSports> getAllSports() async {
    String url = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php";
    var response = await http.get(Uri.parse(url));
    return allSportsFromJson(response.body);
  }

  static Future<SportsList> getSportsLeagues(String countryName) async {
    String url =
        "www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=$countryName";
    var response = await http.get(Uri.https(
        "www.thesportsdb.com", "/api/v1/json/1/search_all_leagues.php", {
      "c": countryName,
    }));
    print(response.body);
    return sportsListFromJson(response.body);
  }

  static Future<SportsList> getFilteredSportsLeagues(
      String countryName, String sportName) async {
    var response = await http.get(Uri.https(
        "www.thesportsdb.com",
        "/api/v1/json/1/search_all_leagues.php",
        {"c": countryName, "s": sportName}));
    print(response.body);
    return sportsListFromJson(response.body);
  }
  // https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=England&s=Baseball
}
