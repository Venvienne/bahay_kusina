// lib/services/auth_service.dart
// ignore_for_file: avoid_print

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

  /// Local authentication (no Firebase needed)
  Future<bool> login(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Mock user creation
      _currentUser = AuthUser(
        userId: 'user_${email.replaceAll('@', '_').replaceAll('.', '_')}',
        email: email,
        fullName: email.split('@')[0],
        phone: '09175551234',
        address: 'Manila, Philippines',
        role: UserRole.customer,
        createdAt: DateTime.now(),
      );

      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  /// Local signup
  Future<bool> signup({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String address,
    required UserRole role,
  }) async {
    try {
      // Validate inputs
      await Future.delayed(const Duration(milliseconds: 800));

      if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
        throw Exception('All fields are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Create mock user
      _currentUser = AuthUser(
        userId: 'user_${email.replaceAll('@', '_').replaceAll('.', '_')}',
        email: email,
        fullName: fullName,
        phone: phone,
        address: address,
        role: role,
        createdAt: DateTime.now(),
      );

      return true;
    } catch (e) {
      print('Signup error: $e');
      return false;
    }
  }

  /// Password reset
  Future<bool> requestPasswordReset(String email) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (email.isEmpty) {
        throw Exception('Email is required');
      }
      return true;
    } catch (e) {
      print('Password reset error: $e');
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    _currentUser = null;
    await Future.delayed(const Duration(milliseconds: 200));
  }

  /// Update user profile
  Future<bool> updateUserProfile({
    required String fullName,
    required String email,
    required String phone,
    required String address,
  }) async {
    try {
      if (_currentUser == null) {
        throw Exception('No user logged in');
      }

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Update the current user
      _currentUser = AuthUser(
        userId: _currentUser!.userId,
        email: email,
        fullName: fullName,
        phone: phone,
        address: address,
        role: _currentUser!.role,
        createdAt: _currentUser!.createdAt,
      );

      return true;
    } catch (e) {
      print('Update profile error: $e');
      return false;
    }
  }

  /// Get user role as string
  String get roleName => _currentUser?.role == UserRole.vendor ? 'vendor' : 'customer';
}
