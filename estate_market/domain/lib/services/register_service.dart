import 'package:domain/entities/wrappers/document_reference_entity.dart';

abstract class RegisterService {
  Future<String?> login(String email, String password);

  Future<void> saveToken(String token, bool stayConnected);
  Future<void> initializeCurrentToken();
  String? getCurrentUserEmail();
  Future<DocumentReferenceEntity?> getCurrentUserDocumentReference();
}
