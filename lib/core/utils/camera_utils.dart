import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraUtils {
  static InputImage? inputImageFromCameraImage(
    CameraImage image,
    CameraDescription camera,
    InputImageRotation rotation,
  ) {
    if (Platform.isIOS) {
      return _inputImageFromCameraImageIOS(image, camera, rotation);
    } else if (Platform.isAndroid) {
      return _inputImageFromCameraImageAndroid(image, camera, rotation);
    }
    return null;
  }

  static InputImage? _inputImageFromCameraImageIOS(
    CameraImage image,
    CameraDescription camera,
    InputImageRotation rotation,
  ) {
    // iOS usually formats as bgra8888 in image.planes[0]
    final format = InputImageFormatValue.fromRawValue(image.format.raw as int);
    if (format == null) return null;

    final bytes = image.planes[0].bytes;
    final size = Size(image.width.toDouble(), image.height.toDouble());

    final metadata = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  static InputImage? _inputImageFromCameraImageAndroid(
    CameraImage image,
    CameraDescription camera,
    InputImageRotation rotation,
  ) {
    if (image.format.group != ImageFormatGroup.yuv420 &&
        image.format.group != ImageFormatGroup.nv21) {
      return null;
    }

    // YUV420 on Android is usually 3 planes: Y, U, V
    // ML Kit expects NV21 for Android by default if we use .nv21 format
    // But image.format.raw might equal 35 (YUV_420_888)

    // Concatenate planes (naive approach often works if strides match,
    // but robust approach handles padding)
    final allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final size = Size(image.width.toDouble(), image.height.toDouble());

    // Force NV21 or YUV420
    final format = InputImageFormat.nv21;

    final metadata = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes[0].bytesPerRow,
    );

    return InputImage.fromBytes(bytes: bytes, metadata: metadata);
  }

  static InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }
}
