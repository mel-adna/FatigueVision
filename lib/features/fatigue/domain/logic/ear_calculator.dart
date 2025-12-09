import 'package:fatigue_vision/features/fatigue/domain/entities/face_landmarks.dart';

class EARCalculator {
  /// Calculates the Eye Aspect Ratio (EAR) for a single eye.
  /// EAR = (||p2-p6|| + ||p3-p5||) / (2 * ||p1-p4||)
  /// We assume contours are ordered 0..N.
  /// ML Kit contours are roughly circular.
  /// Top: 4, 5 (approx)
  /// Bottom: 12, 13 (approx)
  /// Left: 0 (outer), Right: 8 (inner) - for Left Eye.
  /// This requires known indices.
  /// MLKit Contour indices:
  /// 0 is left-most (or right-most), moves clockwise or counter-clockwise.
  /// A robust approximation is:
  /// Height = Average of vertical pairs.
  /// Width = Horizontal distance.

  static double calculate(List<FacePoint> contour) {
    if (contour.length < 6) return 0.0;

    // Approximating based on typical 16-point contour from ML Kit
    // Vertical 1: Top (4) - Bottom (12)
    // Vertical 2: Top (5) - Bottom (11)
    // Horizontal: Left (0) - Right (8)

    // For 13-point or different MLKit versions, this might vary.
    // Let's use simplified bounding box approach if points are unknown,
    // BUT specific indices are better.
    // ML Kit FaceContourType.leftEye usually has 9-16 points.
    // Let's assume we map them to 6 specific points in the mapper if possible,
    // OR just use min/max Y for height and min/max X for width.
    // A robust EAR uses vertical/horizontal.

    // Let's use Min/Max approach for robustness against index shifts.
    // Width = MaxX - MinX
    // Height = MaxY - MinY? No, eyelids curvature matters.
    // Let's stick to indices.
    // Assuming standard 68-point model subset or MLKit equivalent.
    // MLKit Left Eye: 0 is left corner, 8 is right corner. 4 is top, 12 is bottom.

    final p1 = contour[0]; // Left colner
    final p4 = contour[8]; // Right corner

    final p2 = contour[4]; // Top 1
    final p6 = contour[12]; // Bottom 1

    final p3 = contour[5]; // Top 2
    final p5 = contour[11]; // Bottom 2

    final distV1 = p2.distanceTo(p6);
    final distV2 = p3.distanceTo(p5);
    final distH = p1.distanceTo(p4);

    if (distH == 0) return 0.0;

    return (distV1 + distV2) / (2.0 * distH);
  }

  static double calculateAvg(FaceLandmarks landmarks) {
    final leftEAR = calculate(landmarks.leftEyeContour);
    final rightEAR = calculate(landmarks.rightEyeContour);
    return (leftEAR + rightEAR) / 2.0;
  }
}
