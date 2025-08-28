import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static Future<bool> signUp(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('user_$username')) return false;

    await prefs.setString('user_$username', password);
    await prefs.setBool('logged_in', true);
    await prefs.setString('logged_in_user', username);
    return true;
  }

  static Future<bool> logIn(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString('user_$username');
    if (storedPassword == password) {
      await prefs.setBool('logged_in', true);
      await prefs.setString('logged_in_user', username);
      return true;
    }
    return false;
  }

  static Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', false);
    await prefs.remove('logged_in_user');
  }
}
