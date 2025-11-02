import 'dart:io';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/logging.dart';

/// Service for camera capture and OCR number recognition
class CameraOCRService {
  final TextRecognizer _textRecognizer = TextRecognizer();
  final ImagePicker _imagePicker = ImagePicker();
  
  CameraController? cameraController;
  List<CameraDescription>? cameras;
  
  /// Initialize camera
  Future<bool> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        return false;
      }
      
      cameraController = CameraController(
        cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );
      
      await cameraController!.initialize();
      return true;
    } catch (e) {
      AppLogger.error('Error initializing camera', e);
      return false;
    }
  }
  
  /// Capture image and extract roulette number
  Future<int?> captureAndRecognizeNumber() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return null;
    }
    
    try {
      final XFile image = await cameraController!.takePicture();
      return await recognizeNumberFromImage(image.path);
    } catch (e) {
      AppLogger.error('Error capturing image', e);
      return null;
    }
  }
  
  /// Pick image from gallery and recognize number
  Future<int?> pickImageAndRecognizeNumber() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      
      if (image == null) return null;
      
      return await recognizeNumberFromImage(image.path);
    } catch (e) {
      AppLogger.error('Error picking image', e);
      return null;
    }
  }
  
  /// Recognize roulette number from image using OCR
  Future<int?> recognizeNumberFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      // Extract numbers from recognized text
      final numbers = _extractNumbers(recognizedText.text);
      
      // Find valid roulette number (0-36 for European, 0-36 + 00 for American)
      for (var num in numbers) {
        if (num >= 0 && num <= 36) {
          return num;
        }
        // Handle "00" case
        if (num == 0 && recognizedText.text.contains('00')) {
          return 37; // Represent 00 as 37
        }
      }
      
      return null;
    } catch (e) {
      AppLogger.error('Error recognizing number', e);
      return null;
    }
  }
  
  /// Extract numbers from text
  List<int> _extractNumbers(String text) {
    final numberPattern = RegExp(r'\d+');
    final matches = numberPattern.allMatches(text);
    
    return matches
        .map((match) => int.tryParse(match.group(0) ?? ''))
        .where((num) => num != null)
        .cast<int>()
        .toList();
  }
  
  /// Dispose camera resources
  void dispose() {
    cameraController?.dispose();
    _textRecognizer.close();
  }
  
  /// Check if camera is available
  bool get isCameraAvailable => cameraController != null && cameraController!.value.isInitialized;
}
