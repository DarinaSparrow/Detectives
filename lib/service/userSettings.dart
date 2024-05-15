class userSettings {
  static bool vibration = true;
  static bool sound = true;
  static bool music = true;
  static int selectedSpeed = 1;
  static String nickname = '';
  static String status = '';
  static String phoneNumber = '';

  userSettings._();

  static userSettings fromJson(Map<String, dynamic> json) {
    vibration = json['vibration'] ?? true;
    sound = json['sound'] ?? true;
    music = json['music'] ?? true;
    selectedSpeed = json['selectedSpeed'] ?? 1;
    nickname = json['nickname'] ?? '';
    status = json['status'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';

    return userSettings._();
  }

  static Map<String, dynamic> toJson() {
    return {
      'vibration': vibration,
      'sound': sound,
      'music': music,
      'selectedSpeed': selectedSpeed,
      'nickname': nickname,
      'status': status,
      'phoneNumber': phoneNumber,
    };
  }
}
