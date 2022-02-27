import 'package:elemovie/logic/service/encrypt_decrypt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? prefs;

  static dynamic getFromDisk(String key, {bool decrypt = false}) {
    assert(prefs != null);
    var value = prefs?.get(key);
    if (decrypt && value != null) {
      value = EncryptDecryptService.encryptDecryptData(
          content: value, isEncrypt: false);
    }
    if (value is List) return value.cast<String>();
    return value;
  }

  static void saveToDisk<T>(String key, T content, {bool encrypt = false}) {
    assert(prefs != null);
    if (content == null) {
      prefs?.remove(key);
    }
    if (content is String) {
      if (encrypt) {
        var contentEncrypted = EncryptDecryptService.encryptDecryptData(
            content: content, isEncrypt: true);
        prefs?.setString(key, contentEncrypted);
      } else {
        prefs?.setString(key, content);
      }
    } else if (content is bool) {
      prefs?.setBool(key, content);
    } else if (content is int) {
      prefs?.setInt(key, content);
    } else if (content is double) {
      prefs?.setDouble(key, content);
    } else if (content is List<String>) {
      prefs?.setStringList(key, content);
    }
  }

  static void removeFromDisk(String? key, {bool clearAll = false}) {
    if (clearAll) {
      prefs?.clear();
    } else {
      key != null ? saveToDisk(key, null) : null;
    }
  }
}
