import 'failure.dart';

class EmailAlreadyInUse extends RegisterError {}

class InvalidEmail extends RegisterError {}

class InvalidPassword extends RegisterError {}

class InvalidCredential extends RegisterError {}

class MissingEmail extends RegisterError {}

class MissingPassword extends RegisterError {}

class NetworkRequestFailed extends RegisterError {}

class UnknownError extends RegisterError {}
