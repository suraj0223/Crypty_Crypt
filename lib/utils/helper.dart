import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper extends ChangeNotifier {
  // String plainText;
  String encryptedString;
  String decryptedString;

  File image;
  String img64;

  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = encrypt.IV.fromLength(16);

  void setImage(File img, String image64) {
    image = img;
    img64 = image64;
    notifyListeners();
  }

  void aesEncrypt(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    encryptedString = encrypted.base64;
    notifyListeners();
  }

  void aesDecrypt(String plainText) {
     final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    decryptedString = decrypted;
    notifyListeners();
  }
}
