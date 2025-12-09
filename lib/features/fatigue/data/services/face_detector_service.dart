import 'package:camera/camera.dart';
import 'package:fatigue_vision/core/utils/camera_utils.dart';
import 'package:fatigue_vision/features/fatigue/domain/entities/face_landmarks.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FaceDetectorService {
  final FaceDetector _detector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification:
          true, // For verification, though we calc EAR manually
      performanceMode: FaceDetectorMode.fast, // Real-time
    ),
  );

  Future<FaceLandmarks?> processImage(
    CameraImage image,
    CameraDescription camera,
    int sensorOrientation,
  ) async {
    final rotation = CameraUtils.rotationIntToImageRotation(sensorOrientation);
    final inputImage = CameraUtils.inputImageFromCameraImage(
      image,
      camera,
      rotation,
    );

    if (inputImage == null) return null;

    try {
      final faces = await _detector.processImage(inputImage);
      if (faces.isEmpty) return null;

      final face = faces.first; // Track first face

      final leftEye = face.contours[FaceContourType.leftEye];
      final rightEye = face.contours[FaceContourType.rightEye];

      if (leftEye == null || rightEye == null) return null;

      return FaceLandmarks(
        leftEyeContour: leftEye.points
            .map((p) => FacePoint(p.x.toDouble(), p.y.toDouble()))
            .toList(),
        rightEyeContour: rightEye.points
            .map((p) => FacePoint(p.x.toDouble(), p.y.toDouble()))
            .toList(),
      );
    } catch (e) {
      // Log error
      return null;
    }
  }

  void dispose() {
    _detector.close();
  }
}
