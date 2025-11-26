import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/demo_mode.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth? _auth = DemoMode.isEnabled ? null : FirebaseAuth.instance;
  final FirebaseFirestore? _firestore = DemoMode.isEnabled ? null : FirebaseFirestore.instance;
  
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDemoMode = DemoMode.isEnabled;
  
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null || _isDemoMode;
  bool get isDemoMode => _isDemoMode;
  
  AuthViewModel() {
    if (!_isDemoMode && _auth != null) {
      _auth!.authStateChanges().listen((User? user) {
        _currentUser = user;
        notifyListeners();
      });
    } else if (_isDemoMode) {
      // In demo mode, simulate an authenticated user
      _simulateDemoUser();
    }
  }
  
  /// Simulate a demo user for testing without Firebase
  void _simulateDemoUser() {
    // Create a mock user (not a real Firebase User, just simulated state)
    _currentUser = null; // Firebase User not available in demo mode
    // But isAuthenticated will return true because of _isDemoMode
  }
  
  /// Get user ID (works in both real and demo mode)
  String get userId {
    if (_isDemoMode) return DemoMode.demoUserId;
    return _currentUser?.uid ?? '';
  }
  
  /// Get user email (works in both real and demo mode)
  String get userEmail {
    if (_isDemoMode) return DemoMode.demoUserEmail;
    return _currentUser?.email ?? 'anonymous';
  }
  
  /// Sign in anonymously
  Future<bool> signInAnonymously() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      if (_isDemoMode) {
        // Demo mode: simulate successful sign-in
        await Future.delayed(const Duration(milliseconds: 500));
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      final userCredential = await _auth!.signInAnonymously();
      _currentUser = userCredential.user;
      
      // Create user document in Firestore
      if (_currentUser != null) {
        await _firestore!.collection('users').doc(_currentUser!.uid).set({
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
          'subscriptionTier': 'free',
        }, SetOptions(merge: true));
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  /// Sign in with email and password
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      if (_isDemoMode) {
        // Demo mode: simulate successful sign-in
        await Future.delayed(const Duration(milliseconds: 500));
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      final userCredential = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;
      
      // Update last login
      if (_currentUser != null) {
        await _firestore!.collection('users').doc(_currentUser!.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  /// Sign up with email and password
  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      if (_isDemoMode) {
        // Demo mode: simulate successful sign-up
        await Future.delayed(const Duration(milliseconds: 500));
        _isLoading = false;
        notifyListeners();
        return true;
      }
      
      final userCredential = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;
      
      // Create user document
      if (_currentUser != null) {
        await _firestore!.collection('users').doc(_currentUser!.uid).set({
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'subscriptionTier': 'free',
        });
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  
  /// Sign out
  Future<void> signOut() async {
    if (!_isDemoMode && _auth != null) {
      await _auth!.signOut();
    }
    _currentUser = null;
    notifyListeners();
  }
  
  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
