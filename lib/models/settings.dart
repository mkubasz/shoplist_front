class Settings {
  String session = "";
  Settings();

  Settings.fromMappedJson(Map<String, dynamic> json)
      : session = json['session'];

  Map<String, dynamic> toJson() => {
        'session': session,
      };
}
