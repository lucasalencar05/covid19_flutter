import 'dart:convert';
import 'package:covid19_flutter/models/country_model.dart';
import '../data/api.dart';

class CountriesController {

  Future<List<Country>> getAllCountriesInfo() async {
    var response = await netWorking.get(Api.URL_COUNTRIES);
    var list = jsonDecode(response) as List;
    return list.map((item) => Country.fromJson(item)).toList();
  }

  Future<Country> getCountryByName(String country) async {
    var response =
    await netWorking.get('${Api.URL_COUNTRIES}/$country');
    return Country.fromJson(jsonDecode(response));
  }
}
