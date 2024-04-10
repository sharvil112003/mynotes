// Login Exceptions

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// Register Exception

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthExceptions implements Exception {}

class InvalidEmailException implements Exception {}

// Generic Exception
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
