import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/entities/wrappers/document_reference_entity.dart';
import 'package:domain/entities/wrappers/landmark_entity.dart';
import 'package:domain/entities/wrappers/position_entity.dart';
import 'package:domain/repositories/account_repository.dart';
import 'package:domain/repositories/chat_repository.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/repositories/filter_repository.dart';
import 'package:domain/repositories/image_upload_repository.dart';
import 'package:domain/repositories/login_repository.dart';
import 'package:domain/repositories/permission_repository.dart';
import 'package:domain/repositories/position_repository.dart';
import 'package:domain/services/register_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AccountRepository,
  ChatRepository,
  DatabaseRepository,
  FilterRepository,
  ImageUploadRepository,
  LoginRepository,
  PermissionRepository,
  PositionRepository,
  RegisterService,
  AccountEntity,
  AdEntity,
  DocumentReferenceEntity,
  LandmarkEntity,
  MessageEntity,
  PositionEntity,
])
void main() {}
