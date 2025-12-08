// lib/features/auth/provider/auth_provider.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import '../models/auth_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthController _authController = AuthController();

  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser == null) {
        _user = null;
        notifyListeners();
        return;
      }

      _user = await _authController.getUserModel(firebaseUser.uid);
      notifyListeners();
    });
  }

  // ---------------- REGISTER ----------------
  Future<bool> register(String fullName, String email, String password) async {
    _setLoading(true);
    try {
      final firebaseUser = await _authController.register(
        fullName,
        email,
        password,
      );

      if (firebaseUser != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _handleFirebaseError(e.code);
    } catch (e) {
      _errorMessage = 'Registration failed. Please try again.';
    } finally {
      _setLoading(false);
    }
    return false;
  }

  // ---------------- LOGIN ----------------
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final firebaseUser = await _authController.login(email, password);
      if (firebaseUser != null) return true;
      return false;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _handleFirebaseError(e.code);
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
    } finally {
      _setLoading(false);
    }
    return false;
  }

  // ---------------- GOOGLE SIGN-IN ----------------
  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    try {
      final firebaseUser = await _authController.signInWithGoogle();

      if (firebaseUser != null) {
        // Temporary user
        final tempMap = {
          'full_name': firebaseUser.displayName ?? '',
          'email': firebaseUser.email ?? '',
        };

        _user = UserModel.fromMap(tempMap, firebaseUser.uid);

        // Update with Firestore data
        final fetched = await _authController.getUserModel(firebaseUser.uid);
        if (fetched != null) _user = fetched;

        notifyListeners();
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _handleFirebaseError(e.code);
    } catch (e) {
      _errorMessage = 'Google Sign-In failed. Please try again.';
      debugPrint('signInWithGoogle error: $e');
    } finally {
      _setLoading(false);
    }
    return false;
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    await _authController.logout();
    _user = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    if (value) _errorMessage = null;
    notifyListeners();
  }

  String _handleFirebaseError(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password is too weak.';
      case 'email-already-in-use':
        return 'Account already exists with this email.';
      case 'invalid-email':
        return 'Invalid email format.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'network-request-failed':
        return 'No internet connection.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
