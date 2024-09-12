import 'dart:io';

import 'package:bankopol/scanner/data/scan_image_data.dart';
import 'package:bankopol/scanner/platform/mobile_scanner.dart';
import 'package:bankopol/scanner/platform/stub_scanner.dart';

abstract class Scanner {
  /// Implement this method to handle scan with native code.
  Future<String?> scan(ScanImageData imageInfo);

  /// Initializes the scanner and returns whether it succeeded or not
  Future<bool> init() => Future.value(true);

  void dispose() {}

  static final bool _isSupported = Platform.isAndroid || Platform.isIOS;

  static final Scanner instance =
      _isSupported ? MobileScanner() : StubScanner();
}
