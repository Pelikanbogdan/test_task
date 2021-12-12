import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  Future saveLoginName(String loginName) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', loginName);
  }

  Future getLoginName() async {
    final preferences = await SharedPreferences.getInstance();

    final username = preferences.getString('username');
    return username;
  }
}
