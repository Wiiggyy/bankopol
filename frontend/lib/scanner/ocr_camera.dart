// ignore_for_file: colors_from_component_library
import 'dart:io';

import 'package:bankopol/scanner/data/screen.dart';
import 'package:bankopol/scanner/ocr_scanner.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OcrCamera extends StatefulWidget {
  final Function(String value)? onSuccessScanned;
  final bool flashEnabled;

  const OcrCamera({
    super.key,
    this.flashEnabled = false,
    this.onSuccessScanned,
  });

  @override
  State<OcrCamera> createState() => _OcrCameraState();
}

class _OcrCameraState extends State<OcrCamera>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraController? controller;
  OcrScanner? scanner;

  /// referenceNumber = 0
  ///
  /// amount = 1
  ///
  /// recipient = 2
  DateTime _lastFeedback = DateTime.now();
  Screen? cutout;
  late AnimationController scanFeedbackAnimationController;
  late Animation<double> scanFeedbackAnimation;

  bool? initialized;

  @override
  void initState() {
    super.initState();
    initCamera();
    WidgetsBinding.instance.addObserver(this);
    scanFeedbackAnimationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    scanFeedbackAnimation = CurvedAnimation(
      parent: scanFeedbackAnimationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    clearCamera();
    scanFeedbackAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize
    if (!(controller?.value.isInitialized ?? false)) {
      return;
    }
    if (state == AppLifecycleState.resumed) {
      initCamera();
    } else if (state == AppLifecycleState.inactive) {
      clearCamera();
    }
  }

  Future<CameraDescription?> _getCamera(CameraLensDirection dir) async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhereOrNull(
      (camera) => camera.lensDirection == dir,
    );
    return camera ?? cameras.firstOrNull;
  }

  void _failInit() {
    setState(() {
      initialized = false;
    });
  }

  Future<void> initCamera() async {
    final camera = await _getCamera(CameraLensDirection.back);
    if (camera == null) {
      _failInit();
      return;
    }
    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup:
          Platform.isIOS ? ImageFormatGroup.bgra8888 : ImageFormatGroup.nv21,
    );

    try {
      await controller.initialize();
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;

    final scanner = OcrScanner(
      controller,
      rotation: Platform.isIOS ? 0 : camera.sensorOrientation,
    );

    if (!await scanner.init()) {
      _failInit();
      return;
    }

    scanner.analyze().listen((event) {
      if (!mounted) return;

      // If we have a success, let's (maybe) vibrate phone a bit

      var shouldFeedback = false;

      if (_lastFeedback.millisecondsElapsed(1000)) {
        _lastFeedback = DateTime.now();
        shouldFeedback = true;
      }

      if (shouldFeedback) {
        scanFeedbackAnimationController.forward().then(
              (value) => scanFeedbackAnimationController.reverse(),
            );
        HapticFeedback.lightImpact();
      }
      widget.onSuccessScanned?.call(event);
    });
    setState(() {
      initialized = true;
      this.controller = controller;
      this.scanner = scanner;
    });
  }

  void clearCamera() {
    scanner?.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;

    if (initialized == null) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    if (initialized == false ||
        controller == null ||
        !controller.value.isInitialized) {
      return const Text("Kunde inte starta skanning");
    }

    try {
      controller.setFlashMode(
        widget.flashEnabled ? FlashMode.torch : FlashMode.off,
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return AspectRatio(
      aspectRatio: 1 / controller.value.aspectRatio,
      child: CameraPreview(
        controller,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cameraWidth = controller.value.previewSize!.height;
            final cameraHeight = controller.value.previewSize!.width;
            final scale = constraints.maxHeight / cameraHeight;

            final cutout = Screen(
              imageWidth: cameraWidth,
              imageHeight: cameraHeight,
              scale: scale,
            );

            this.cutout = cutout;

            return Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: scanFeedbackAnimation,
                    builder: (context, child) {
                      return ColoredBox(
                        color: const Color(0xff000000)
                            .withOpacity(scanFeedbackAnimation.value),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: ClipPath(
                    clipper: ScanCutout(screen: cutout),
                    child: ColoredBox(
                      color: const Color(0xff000000).withOpacity(.6),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScanCutout extends CustomClipper<Path> {
  final Screen screen;

  const ScanCutout({required this.screen});

  @override
  Path getClip(Size size) {
    const radius = Radius.circular(4);
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRRect(RRect.fromRectAndRadius(screen.qrCutout, radius)),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension on DateTime {
  bool millisecondsElapsed(int milliseconds) {
    return DateTime.now().difference(this).inMilliseconds > milliseconds;
  }
}
