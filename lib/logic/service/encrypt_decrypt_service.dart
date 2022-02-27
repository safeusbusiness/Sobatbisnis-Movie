import 'package:elemovie/config/app_env.dart';
import 'package:encrypt/encrypt.dart';

class EncryptDecryptService {
  static String encryptDecryptData(
      {required var content, bool isEncrypt = true}) {
    final _key = Key.fromUtf8(EnvironmentConfig.secretKeyIv());
    final _iv = IV.fromUtf8(EnvironmentConfig.secretKeyIv(isGetKey: false));
    final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    RegExp regExp = new RegExp(
        r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
    String contentString = content ?? '';
    if (contentString == '') {
      return contentString;
    } else {
      if (isEncrypt) {
        var contentEncrypted = _encrypter.encrypt(contentString, iv: _iv);
        return contentEncrypted.base64;
      } else {
        try {
          var contentDecrypted = _encrypter.decrypt64(contentString, iv: _iv);
          if (regExp.hasMatch(content)) {
            return contentDecrypted;
          } else {
            return content;
          }
        } catch (e) {
          return contentString;
        }
      }
    }
  }
}
