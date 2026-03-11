import 'models/auth_user.dart';

class AuthSession {
  static AuthUser? currentUser;

  static bool get isLoggedIn => currentUser != null;

  static void logout() {
    currentUser = null;
  }
}