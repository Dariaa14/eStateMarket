abstract class Failure {}

class UnknownError extends Failure {}

abstract class RegisterError extends Failure {}

abstract class LoginError extends Failure {}

abstract class DatabaseError extends Failure {}
