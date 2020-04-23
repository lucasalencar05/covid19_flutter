import 'dart:convert';
import 'package:covid19_flutter/models/globalinfo_model.dart';
import '../data/api.dart';

class GlobalController {

  Future<GlobalInfo> getGlobalInfo() async {
    String response = await netWorking.get(Api.URL_GLOBAL);
    return GlobalInfo.fromJson(jsonDecode(response));

  }
}
