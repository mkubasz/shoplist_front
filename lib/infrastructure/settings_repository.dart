import 'dart:convert';

import 'package:duck_shop/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'in_memory_data_provider.dart';

class SettingsRepository {
  InMemoryDataProvider inMemoryDataProvider = InMemoryDataProvider();
  Future<Settings> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var element = prefs.getString("settings");
    if (element != null) {
      return Settings.fromMappedJson(json.decode(element));
    }
    return Settings();
  }

  Future update(Settings settings) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("settings")) {
      prefs.remove("settings");
      prefs.commit();
      prefs.setString("settings", json.encode(settings.toJson()));
    }
  }
}
