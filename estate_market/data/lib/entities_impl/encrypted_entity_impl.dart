import 'package:domain/entities/encrypted_entity.dart';
import 'package:encrypt/encrypt.dart';

class EncryptedEntityImpl implements EncryptedEntity {
  final Encrypted ref;

  EncryptedEntityImpl({required this.ref});

  @override
  String getBase16() => ref.base16;

  @override
  String getBase64() => ref.base64;
}
