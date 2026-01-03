// lib/services/auth_service.dart
import 'dart:async';

enum UserRole { customer, vendor }

class AuthUser {
  final String userId;
  final String email;
  final String fullName;
  final String phone;
  final String address;
  final UserRole role;
  final DateTime createdAt;

  const AuthUser({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.role,
    required this.createdAt,
  });
}

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  AuthUser? _currentUser;

  AuthUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  String get userRole => _currentUser?.role == UserRole.vendor ? "Vendor" : "Customer";

  // Mock login - in production, this would connect to Firebase or API
  Future<bool> login(String emailOrPhone, String password, UserRole role) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock validation
      if (emailOrPhone.isEmpty || password.isEmpty) {
        throw Exception('Email/Phone and password are required');
      }

      // Create mock user
      _currentUser = AuthUser(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: emailOrPhone.contains('@') ? emailOrPhone : 'user@example.com',
        fullName: 'Juan Dela Cruz',
        phone: emailOrPhone.contains('@') ? '09171234567' : emailOrPhone,
        address: '123 Sampaguita St., Quezon City',
        role: role,
        createdAt: DateTime.now(),
      );

      return true;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // Mock signup
  Future<bool> signup({
    required String fullName,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String confirmPassword,
    required UserRole role,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock validation
      if (fullName.isEmpty ||
          email.isEmpty ||
          phone.isEmpty ||
          address.isEmpty ||
          password.isEmpty) {
        throw Exception('All fields are required');
      }

      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }

      if (password.length < 8) {
        throw Exception('Password must be at least 8 characters');
      }

      // Create mock user
      _currentUser = AuthUser(
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        fullName: fullName,
        phone: phone,
        address: address,
        role: role,
        createdAt: DateTime.now(),
      );

      return true;
    } catch (e) {
      throw Exception('Signup failed: ${e.toString()}');
    }
  }

  // Mock password reset
  Future<bool> requestPasswordReset(String emailOrPhone) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (emailOrPhone.isEmpty) {
        throw Exception('Email or phone is required');
      }

      // In production, this would send an email/SMS
      return true;
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  // Logout
  void logout() {
    _currentUser = null;
  }

  // Check authentication status
  bool isLoggedIn() {
    return _currentUser != null;
  }
}
