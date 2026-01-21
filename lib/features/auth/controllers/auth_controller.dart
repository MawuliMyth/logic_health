import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_model.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final GoogleSignIn _googleSignIn;
  bool _isInitialized = false;

  final List<String> _scopes = ['email', 'profile'];

  AuthController() {
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    if (_isInitialized) return;
    _googleSignIn = GoogleSignIn.instance;
    try {
      await _googleSignIn.initialize(
        serverClientId:
            '638647218338-cs6qvp71iuk9p0hlhip1ig2kmpsnr947.apps.googleusercontent.com',
      );
      _isInitialized = true;
      debugPrint('GoogleSignIn initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize GoogleSignIn: $e');
    }
  }

  User? get currentUser => _auth.currentUser;

  // Updated Registration with Name Validation
  Future<User?> register(String fullName, String email, String password) async {
    try {
      final String trimmedName = fullName.trim();

      // 🛑 LOGIC GUARD: Enforce standard naming
      if (trimmedName.length < 4 || !trimmedName.contains(' ')) {
        throw FirebaseAuthException(
          code: 'invalid-name',
          message: 'A valid full name (First and Last) is required.',
        );
      }

      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final User? user = cred.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'full_name': trimmedName,
          'email': email.trim(),
          'photo_url': null,
          'created_at': FieldValue.serverTimestamp(),
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Registration error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected registration error: $e');
      rethrow;
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return cred.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('Login error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected login error: $e');
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      if (!_isInitialized) await _initializeGoogleSignIn();

      GoogleSignInAccount? googleUser;
      final lightweightResult = await _googleSignIn
          .attemptLightweightAuthentication();

      if (lightweightResult != null) {
        googleUser = lightweightResult;
      } else {
        if (!_googleSignIn.supportsAuthenticate()) {
          throw Exception('Platform does not support Google Sign-In');
        }
        googleUser = await _googleSignIn.authenticate(scopeHint: _scopes);
      }

      if (googleUser == null) return null;

      final GoogleSignInAuthentication auth = await googleUser.authentication;
      if (auth.idToken == null) throw Exception('No ID token received');

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);
      final UserCredential userCred = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCred.user;

      if (user == null) return null;

      final docRef = _firestore.collection('users').doc(user.uid);
      final doc = await docRef.get();

      final userData = <String, dynamic>{
        'full_name':
            user.displayName ?? googleUser.displayName ?? 'Google User',
        'email': user.email ?? googleUser.email,
        'photo_url': user.photoURL ?? googleUser.photoUrl,
        'updated_at': FieldValue.serverTimestamp(),
      };

      if (!doc.exists) {
        userData['created_at'] = FieldValue.serverTimestamp();
        await docRef.set(userData);
      } else {
        await docRef.update(userData);
      }

      return user;
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      if (_isInitialized) await _googleSignIn.signOut();
      debugPrint('User logged out successfully');
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<UserModel?> getUserModel(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!, uid);
    } catch (e) {
      debugPrint('Error fetching user model: $e');
      return null;
    }
  }
}
