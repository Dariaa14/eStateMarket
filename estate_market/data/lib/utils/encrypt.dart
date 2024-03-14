import 'package:data/config.dart';
import 'package:encrypt/encrypt.dart';

import '../entities_impl/wrappers/encrypted_entity_impl.dart';
import 'package:domain/entities/wrappers/encrypted_entity.dart';

String encryptValue(String text) {
  final key = Key.fromUtf8(encriptedKey);

  final encrypter = Encrypter(AES(key));

  final EncryptedEntity encrypted = EncryptedEntityImpl(ref: encrypter.encrypt(text, iv: iv));

  return encrypted.getBase16();
}

String decryptValue(String text) {
  final key = Key.fromUtf8(encriptedKey);

  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt16(text, iv: iv);

  return decrypted;
}
