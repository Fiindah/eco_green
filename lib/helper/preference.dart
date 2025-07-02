import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static const String _tokenKey = "token";
  static const String _isLoginKey = "is_login";
  static const String _userNameKey = "user_name"; // New key for user name
  static const String _userEmailKey = "user_email"; // New key for user email

  // Save token
  static Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
    await pref.setBool(_isLoginKey, true); // Set login status to true
  }

  // Get token
  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  // Get login status
  static Future<bool> getLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(_isLoginKey) ?? false; // Default to false if not found
  }

  // Save user name
  static Future<void> saveUserName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_userNameKey, name);
  }

  // Get user name
  static Future<String?> getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_userNameKey);
  }

  // Save user email
  static Future<void> saveUserEmail(String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_userEmailKey, email);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_userEmailKey);
  }

  // Clear all preferences (for logout)
  static Future<void> clearAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

// import 'package:shared_preferences/shared_preferences.dart';

// class SharePref {
//   static const String _loginKey = "login";
//   static const String _tokenKey = "token";

//   static void saveLogin(bool login) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool(_loginKey, login);
//   }

//   static void saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_tokenKey, token);
//   }

//   static Future<bool> getLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     bool? login = prefs.getBool(_loginKey) ?? false;
//     return login;
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString(_tokenKey);
//     return token;
//   }

//   static void deleteLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(_loginKey);
//   }
// }
