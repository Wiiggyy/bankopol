import 'package:bankopol/scanner/platform/scanner.dart';

class StubScanner extends Scanner {
  @override
  Future<String> scan(_) => throw UnimplementedError();
}
