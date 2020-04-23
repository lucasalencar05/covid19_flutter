import 'package:http/http.dart';
import '../util/networking.dart';

final client = Client();

final netWorking= Networking();

final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
final Function mathFunc = (Match match) => '${match[1]}.';

abstract class Api {

  static const String HOST = 'https://corona.lmao.ninja/v2';
  static const String URL_GLOBAL = '$HOST/all';
  static const String URL_COUNTRIES = '$HOST/countries';
}

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
}