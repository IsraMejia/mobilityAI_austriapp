import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ScanStatus { idle, scanning, uploading, success }

class ScanFaceNotifier extends Notifier<ScanStatus> {
  @override
  ScanStatus build() => ScanStatus.idle;

  Future<void> startScan() async {
    // 1. Simula inicio
    state = ScanStatus.scanning;
    await Future.delayed(const Duration(seconds: 2));
    
    // 2. Simula subida
    state = ScanStatus.uploading;
    await Future.delayed(const Duration(seconds: 2));
    
    // 3. Éxito (Aquí redirigiríamos o mostraríamos confirmación)
    state = ScanStatus.success;
    
    // Reset para demo
    await Future.delayed(const Duration(seconds: 1));
    state = ScanStatus.idle;
  }
}

final scanFaceProvider = NotifierProvider<ScanFaceNotifier, ScanStatus>(ScanFaceNotifier.new);