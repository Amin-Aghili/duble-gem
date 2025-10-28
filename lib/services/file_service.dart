import 'package:shared_preferences/shared_preferences.dart';

class FileService {
  static const _lastOpenedFileKey = 'last_opened_file';

  Future<void> saveLastOpenedFile(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastOpenedFileKey, path);
  }

  Future<String?> getLastOpenedFile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastOpenedFileKey);
  }
}
