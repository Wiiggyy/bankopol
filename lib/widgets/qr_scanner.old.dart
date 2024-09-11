import 'dart:io';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late final BarcodeScanner barcodeScanner;
  CameraController? cameraController;
  bool initialized = false;
  bool isProcessing = false;

  @override
  void initState() {
    barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

    _getCamera(CameraLensDirection.back).then(
      (camera) {
        if (camera == null) return;
        cameraController = CameraController(
          camera,
          ResolutionPreset.high,
          enableAudio: false,
          imageFormatGroup: Platform.isIOS
              ? ImageFormatGroup.bgra8888
              : ImageFormatGroup.nv21,
        )..initialize().then((_) {
            setState(() {
              initialized = true;
            });
            cameraController?.startImageStream(
              (image) async {
                if (isProcessing) return;
                isProcessing = true;
                try {
                  const orientations = {
                    DeviceOrientation.portraitUp: 0,
                    DeviceOrientation.landscapeLeft: 90,
                    DeviceOrientation.portraitDown: 180,
                    DeviceOrientation.landscapeRight: 270,
                  };

                  final sensorOrientation = camera.sensorOrientation;
                  InputImageRotation? rotation;

                  if (Platform.isIOS) {
                    rotation =
                        InputImageRotationValue.fromRawValue(sensorOrientation);
                  } else if (Platform.isAndroid) {
                    var rotationCompensation =
                        orientations[cameraController!.value.deviceOrientation];
                    if (rotationCompensation == null) return;
                    if (camera.lensDirection == CameraLensDirection.front) {
                      // front-facing
                      rotationCompensation =
                          (sensorOrientation + rotationCompensation) % 360;
                    } else {
                      // back-facing
                      rotationCompensation =
                          (sensorOrientation - rotationCompensation + 360) %
                              360;
                    }
                    rotation = InputImageRotationValue.fromRawValue(
                        rotationCompensation);
                  }

                  // get image format
                  final format =
                      InputImageFormatValue.fromRawValue(image.format.raw);
                  // validate format depending on platform
                  // only supported formats:
                  // * nv21 for Android
                  // * bgra8888 for iOS
                  var planeBytes = image.planes.first.bytes;
                  if (format == null) throw 'No format';
                  if ((Platform.isAndroid && format != InputImageFormat.nv21) ||
                      (Platform.isIOS && format != InputImageFormat.bgra8888)) {
                    if (format == InputImageFormat.yuv_420_888) {
                      planeBytes = convertYuv420(image);
                    } else {
                      throw 'Format error got $format';
                    }
                  }

                  if (rotation == null) throw 'No rotation';
                  final inputImage = InputImage.fromBytes(
                    bytes: planeBytes,
                    metadata: InputImageMetadata(
                      size:
                          Size(image.width.toDouble(), image.height.toDouble()),
                      rotation: rotation, // used only in Android
                      format: format, // used only in iOS
                      bytesPerRow:
                          image.planes.first.bytesPerRow, // used only in iOS
                    ),
                  );
                  await _scanQrCode(inputImage);
                } catch (e, stackTrace) {
                  debugPrintStack(stackTrace: stackTrace);
                } finally {
                  isProcessing = false;
                }
              },
            );
          });
        setState(() {});
      },
    );
    super.initState();
  }

  Future<CameraDescription?> _getCamera(CameraLensDirection dir) async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhereOrNull(
      (camera) => camera.lensDirection == dir,
    );
    return camera ?? cameras.firstOrNull;
  }

  @override
  void dispose() {
    barcodeScanner.close();
    cameraController?.dispose();
    super.dispose();
  }

  Future<String?> _scanQrCode(InputImage inputImage) {
    return barcodeScanner.processImage(inputImage).then(
      (value) {
        final text = value.firstOrNull?.rawValue;
        if (text == null) {
          return null;
        }
        return text;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(32),
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: switch (cameraController) {
          final controller? when initialized => AspectRatio(
              aspectRatio: 1 / controller.value.aspectRatio,
              child: CameraPreview(
                controller,
              ),
            ),
          _ => const CircularProgressIndicator.adaptive(),
        });
  }
}

class QrScannerToggle extends StatefulWidget {
  const QrScannerToggle({super.key});

  @override
  State<QrScannerToggle> createState() => _QrScannerToggleState();
}

class _QrScannerToggleState extends State<QrScannerToggle> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isOn) const QrScanner(),
        IconButton(
          onPressed: () {
            setState(() {
              isOn = !isOn;
            });
          },
          icon: Icon(switch (isOn) {
            true => Icons.camera_alt,
            false => Icons.camera_alt_outlined,
          }),
        ),
      ],
    );
  }
}

Uint8List convertYuv420(CameraImage image) {
  final int width = image.width;
  final int height = image.height;

  final int ySize = width * height;
  final int uvSize = ySize ~/ 2;

  final Uint8List nv21 = Uint8List(ySize + uvSize);

  // Y plane
  nv21.setRange(0, ySize, image.planes[0].bytes);

  final bytesPerPixel = image.planes[1].bytesPerPixel!;
  final bytesPerRow = image.planes[1].bytesPerRow;

  // U and V planes interleaved
  int index = ySize;
  for (int j = 0; j < height ~/ 2; j++) {
    for (int i = 0; i < width ~/ 2; i++) {
      final int uvIndex = j * bytesPerRow + i * bytesPerPixel;
      nv21[index++] = image.planes[2].bytes[uvIndex]; // V
      nv21[index++] = image.planes[1].bytes[uvIndex]; // U
    }
  }

  return nv21;
}
