import 'dart:math';

class FacePoint {
  final double x;
  final double y;

  const FacePoint(this.x, this.y);

  double distanceTo(FacePoint other) {
    return sqrt(pow(x - other.x, 2) + pow(y - other.y, 2));
  }
}

class FaceLandmarks {
  final List<FacePoint> leftEyeContour;
  final List<FacePoint> rightEyeContour;

  const FaceLandmarks({
    required this.leftEyeContour,
    required this.rightEyeContour,
  });
}
