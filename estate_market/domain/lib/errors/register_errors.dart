import 'failure.dart';

class EmailAlreadyInUse extends RegisterError {}

class InvalidEmail extends RegisterError {}

class PasswordTooWeak extends RegisterError {}

class PasswordTooShort extends RegisterError {}

class MissingEmail extends RegisterError {}

class MissingPassword extends RegisterError {}

class NetworkRequestFailed extends RegisterError {}

class InvalidCredential extends LoginError {}
