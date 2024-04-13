import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('Cannot log out if initialized', () {
      expect(provider.logOut(), TypeMatcher<NotInitializedException>());
    });

    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('User should be nullafter initialization', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to initialize in less then 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(const Duration(seconds: 2)));

    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: 'foo@bar.com',
        password: 'anypass',
      );

      expect(badEmailUser, const TypeMatcher<UserNotFoundAuthException>());

      final badPasswordUser =
          provider.createUser(email: 'someone@bar.com', password: '121212');

      expect(badPasswordUser, const TypeMatcher<WrongPasswordAuthException>());

      final user = await provider.createUser(email: 'foo', password: 'bar');

      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('Login user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to login and logout again', () async {
      await provider.logOut();
      await provider.logIn(email: 'email', password: 'password');

      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  AuthUser? _user;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'sharvil.22111277@viit.ac.in') {
      throw UserNotFoundAuthException();
    }

    if (password == '12121212') throw WrongPasswordAuthException();
    const user = AuthUser(
        id: 'my_id',
        isEmailVerified: false,
        email: 'sharvil.22111277@viit.ac.in');
    _user = user;

    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 2));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
        id: 'my_id',
        isEmailVerified: true,
        email: 'sharvil.22111277@viit.ac.in');
    _user = newUser;
  }
}
