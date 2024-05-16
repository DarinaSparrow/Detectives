class userSettings {
  static bool vibration = true;
  static bool sound = true;
  static int selectedSpeed = 1;
  static String phoneNumber = '';

  userSettings._();

  static userSettings fromJson(Map<String, dynamic> json) {
    vibration = json['vibration'] ?? true;
    sound = json['sound'] ?? true;
    selectedSpeed = json['selectedSpeed'] ?? 1;
    phoneNumber = json['phoneNumber'] ?? '';

    return userSettings._();
  }

  static Map<String, dynamic> toJson() {
    return {
      'vibration': vibration,
      'sound': sound,
      'selectedSpeed': selectedSpeed,
      'phoneNumber': phoneNumber,
    };
  }
}
