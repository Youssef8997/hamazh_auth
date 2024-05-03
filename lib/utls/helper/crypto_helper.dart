import 'package:encrypt/encrypt.dart';

class CryptoHelper {
  String encrypt({required String inputString}) {
    final key = Key.fromUtf8('HAMAZAHaUTHtEST.................');
    final iv = IV.fromUtf8("hamazahAuth");

    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(inputString, iv: iv);
    return encrypted.base16;
  }

  String decrypt({
    required String inputString,
  }) {
    final key = Key.fromUtf8('HAMAZAHaUTHtEST.................');
    final iv = IV.fromUtf8("hamazahAuth");

    final encrypterw = Encrypter(AES(key));

    final encryptedFile = Encrypted.fromBase16(inputString);
    final decrypted = encrypterw.decrypt(encryptedFile, iv: iv);

    return decrypted;
  }
}
