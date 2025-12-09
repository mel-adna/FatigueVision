import 'dart:math';

class FacePoint {
  const FacePoint(this.x, this.y);

  final double x;
  final double y;

  double distanceTo(FacePoint other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }
}

class FaceLandmarks {
  const FaceLandmarks({
    required this.leftEyeContour,
    required this.rightEyeContour,
  });

  final List<FacePoint> leftEyeContour;
  final List<FacePoint> rightEyeContour;
}
