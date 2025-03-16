import 'package:freecodecamp/services/auth/auth_user.dart';

abstract class AuthProvider1{
  Future<void> initialize();
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
      required String email,
      required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({required String toEmail});
}