import 'package:hospice_app/features/ehr/domain/user_role.dart';
import 'models/auth_user.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  AuthUser? _currentUser;

  AuthUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<AuthUser?> login(String email, String password) async {
    // Mock authentication logic
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Simple mock: based on email domain or content
    UserRole role;
    String name;
    if (email.contains('admin')) {
      role = UserRole.admin;
      name = 'Admin User';
    } else if (email.contains('caregiver') || email.contains('cna')) {
      role = UserRole.caregiver;
      name = 'Caregiver User';
    } else if (email.contains('family') || email.contains('relative')) {
      role = UserRole.relative;
      name = 'Family Member';
    } else {
      // Default or invalid
      return null;
    }

    // For demo, assume password is always correct if email matches
    if (password.isEmpty) return null;

    _currentUser = AuthUser(
      id: email,
      name: name,
      role: role,
    );

    return _currentUser;
  }

  void logout() {
    _currentUser = null;
  }
}