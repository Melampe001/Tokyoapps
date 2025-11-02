import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibration/vibration.dart';
import '../models/spin_result.dart';
import '../models/prediction.dart';
import '../models/user_subscription.dart';
import '../services/rng_service.dart';
import '../services/prediction_service.dart';
import '../services/storage_service.dart';
import '../services/camera_ocr_service.dart';

class RouletteViewModel extends ChangeNotifier {
  final RNGService _rngService = RNGService();
  final PredictionService _predictionService = PredictionService();
  final StorageService _storageService = StorageService();
  final CameraOCRService _cameraOCRService = CameraOCRService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // State
  bool _isEuropean = true;
  List<SpinResult> _history = [];
  Prediction? _currentPrediction;
  UserSubscription _subscription = UserSubscription(
    userId: '',
    tier: SubscriptionTier.free,
  );
  
  bool _isLoading = false;
  String? _errorMessage;
  int? _lastSpinNumber;
  bool _isCameraInitialized = false;
  
  // Getters
  bool get isEuropean => _isEuropean;
  List<SpinResult> get history => _history;
  Prediction? get currentPrediction => _currentPrediction;
  UserSubscription get subscription => _subscription;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int? get lastSpinNumber => _lastSpinNumber;
  bool get isCameraInitialized => _isCameraInitialized;
  
  // Spin counts for testing requirements
  int get manualSpinCount => _history.where((s) => s.method == 'manual').length;
  int get cameraSpinCount => _history.where((s) => s.method == 'camera').length;
  
  RouletteViewModel() {
    _initialize();
  }
  
  Future<void> _initialize() async {
    _isLoading = true;
    notifyListeners();
    
    // Load subscription from storage
    final savedSubscription = await _storageService.getSubscription();
    if (savedSubscription != null) {
      _subscription = savedSubscription;
    }
    
    // Load spin history from local storage
    _history = await _storageService.getRecentSpins(limit: 500);
    
    // Generate initial prediction if we have history
    if (_history.isNotEmpty) {
      _updatePrediction();
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  /// Toggle between European and American roulette
  void toggleRouletteType() {
    _isEuropean = !_isEuropean;
    _updatePrediction();
    notifyListeners();
  }
  
  /// Perform manual spin
  Future<void> performManualSpin() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Generate random number
      final number = _rngService.generateNumber(
        isEuropean: _isEuropean,
        history: _history,
        useWeighting: true,
      );
      
      // Create spin result
      final spin = SpinResult(
        number: number,
        timestamp: DateTime.now(),
        method: 'manual',
        isEuropean: _isEuropean,
      );
      
      // Save to storage
      await _storageService.saveSpinResult(spin);
      
      // Save to Firebase if user is authenticated
      try {
        await _firestore.collection('spins').add(spin.toJson());
      } catch (e) {
        // Ignore Firebase errors in offline mode
        print('Firebase save failed (offline?): $e');
      }
      
      // Update history
      _history.insert(0, spin);
      _lastSpinNumber = number;
      
      // Vibrate on spin
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 100);
      }
      
      // Update prediction
      _updatePrediction();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error performing spin: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Initialize camera for OCR
  Future<bool> initializeCamera() async {
    try {
      _isCameraInitialized = await _cameraOCRService.initializeCamera();
      notifyListeners();
      return _isCameraInitialized;
    } catch (e) {
      _errorMessage = 'Error initializing camera: $e';
      _isCameraInitialized = false;
      notifyListeners();
      return false;
    }
  }
  
  /// Perform camera-based spin using OCR
  Future<void> performCameraSpin() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Capture and recognize number
      final number = await _cameraOCRService.captureAndRecognizeNumber();
      
      if (number == null) {
        _errorMessage = 'Could not recognize number. Please try again.';
        _isLoading = false;
        notifyListeners();
        return;
      }
      
      // Validate number range
      final maxNumber = _isEuropean ? 36 : 37;
      if (number < 0 || number > maxNumber) {
        _errorMessage = 'Invalid number detected: $number';
        _isLoading = false;
        notifyListeners();
        return;
      }
      
      // Create spin result
      final spin = SpinResult(
        number: number,
        timestamp: DateTime.now(),
        method: 'camera',
        isEuropean: _isEuropean,
      );
      
      // Save to storage
      await _storageService.saveSpinResult(spin);
      
      // Save to Firebase
      try {
        await _firestore.collection('spins').add(spin.toJson());
      } catch (e) {
        print('Firebase save failed (offline?): $e');
      }
      
      // Update history
      _history.insert(0, spin);
      _lastSpinNumber = number;
      
      // Vibrate
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 150);
      }
      
      // Update prediction
      _updatePrediction();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error performing camera spin: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Update prediction based on current history
  void _updatePrediction() {
    _currentPrediction = _predictionService.generatePrediction(
      history: _history,
      tier: _subscription.tier,
      isEuropean: _isEuropean,
    );
  }
  
  /// Get prediction text based on subscription tier
  String getPredictionText() {
    if (_currentPrediction == null) {
      return 'No prediction available. Spin to generate predictions.';
    }
    
    switch (_subscription.tier) {
      case SubscriptionTier.free:
        return _currentPrediction!.getBasicPredictionText();
      case SubscriptionTier.advanced:
        return _currentPrediction!.getAdvancedPredictionText();
      case SubscriptionTier.premium:
        return _currentPrediction!.getPremiumPredictionText();
    }
  }
  
  /// Clear spin history
  Future<void> clearHistory() async {
    await _storageService.clearSpinHistory();
    _history.clear();
    _currentPrediction = null;
    _lastSpinNumber = null;
    notifyListeners();
  }
  
  /// Update subscription tier
  Future<void> updateSubscription(SubscriptionTier tier) async {
    _subscription = UserSubscription(
      userId: _subscription.userId,
      tier: tier,
      purchaseDate: DateTime.now(),
      isActive: true,
    );
    
    await _storageService.saveSubscription(_subscription);
    _updatePrediction();
    notifyListeners();
  }
  
  /// Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  
  @override
  void dispose() {
    _cameraOCRService.dispose();
    super.dispose();
  }
}
