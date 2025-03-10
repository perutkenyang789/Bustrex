import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  static late SharedPreferences _prefs;
  static bool _isInitialized = false;

  static const defaultProfile = Profile(
    name: 'Bustrex User',
    nickname: 'movieJunkie',
    bio: "Hey! I'm watching movies on Bustrex!",
    hobby: 'Bustrex and Chill',
    instagramUsername: 'movieJunkie',
    twitterUsername: 'movieJunkie',
  );

  static Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  static Future<void> setProfile(Profile profile) async {
    await init(); // Ensure _prefs is initialized

    final String profileJson = jsonEncode(profile.toJson());
    await _prefs.setString('profile', profileJson);
  }

  static Future<Profile> getProfile() async {
    await init(); // Ensure _prefs is initialized

    final String? profileJson = _prefs.getString('profile');
    if (profileJson == null) {
      return const Profile(
        name: "Bustrex User",
        nickname: "movieJunkie",
        bio: "",
        hobby: "Bustrex and Chill",
        instagramUsername: "",
        twitterUsername: "",
      );
    }
    return Profile.fromJson(jsonDecode(profileJson));
  }
}
