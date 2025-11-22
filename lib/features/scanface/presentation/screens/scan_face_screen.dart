import 'package:austriapp/features/scanface/presentation/providers/scan_face_provider.dart.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:austriapp/core/theme/app_colors.dart';
import 'package:austriapp/features/map/presentation/widgets/navigation_menu_drawer.dart';

@RoutePage()
class ScanFaceScreen extends ConsumerWidget {
  const ScanFaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanStatus = ref.watch(scanFaceProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.neonGreen), // Hamburguesa verde
      ),
      drawer: const NavigationMenuDrawer(), // ¡Integración con el Drawer!
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 1. Título Superior
            _buildHeader(),

            // 2. Área Central de Escaneo (Círculo y brackets)
            _buildScannerVisual(scanStatus),

            // 3. Botones de Acción e Instrucciones
            _buildActionArea(context, ref, scanStatus),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Widgets Modulares (Private Helper Methods)
  // ---------------------------------------------------------------------------

  Widget _buildHeader() {
    return const Text(
      'Escaneo Facial',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildScannerVisual(ScanStatus status) {
    // Efecto visual: cambia grosor o color según estado
    final isActive = status == ScanStatus.scanning || status == ScanStatus.uploading;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Brackets (Esquinas) - Simulados con un contenedor y borde
        SizedBox(
          width: 280,
          height: 280,
          child: CustomPaint(
            painter: _CornerBracketsPainter(), // Definido abajo para limpieza
          ),
        ),
        
        // Círculo Central
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? AppColors.neonGreenAccent : AppColors.neonGreen,
              width: isActive ? 4 : 3,
            ),
            boxShadow: isActive 
              ? [BoxShadow(color: AppColors.neonGreen.withOpacity(0.4), blurRadius: 20)] 
              : [],
          ),
          child: Center(
            child: Icon(
              Icons.face, // Icono de carita feliz simple
              size: 80,
              color: AppColors.neonGreen.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionArea(BuildContext context, WidgetRef ref, ScanStatus status) {
    String statusText;
    switch (status) {
      case ScanStatus.scanning: statusText = 'Escaneando...'; break;
      case ScanStatus.uploading: statusText = 'Subiendo...'; break;
      case ScanStatus.success: statusText = '¡Listo!'; break;
      default: statusText = 'Alinee su rostro dentro del círculo';
    }

    return Column(
      children: [
        // Texto de Instrucción / Estado
        Text(
          statusText,
          style: TextStyle(
            color: status == ScanStatus.idle ? AppColors.neonGreen : Colors.white,
            fontSize: 16,
          ),
        ),
        
        const SizedBox(height: 40),

        // Botón de Cámara
        GestureDetector(
          onTap: status == ScanStatus.idle 
            ? () => ref.read(scanFaceProvider.notifier).startScan() 
            : null,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.neonGreen, width: 3),
              color: Colors.black,
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: status == ScanStatus.idle 
                  ? Colors.transparent 
                  : AppColors.neonGreen.withOpacity(0.2),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
        
        if (status == ScanStatus.uploading)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('Subiendo...', style: TextStyle(color: AppColors.neonGreen)),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Painter Auxiliar para las esquinas (Estilo Viewfinder)
// ---------------------------------------------------------------------------
class _CornerBracketsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonGreen
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double cornerLength = 30.0;

    // Top Left
    canvas.drawPath(Path()..moveTo(0, cornerLength)..lineTo(0, 0)..lineTo(cornerLength, 0), paint);
    // Top Right
    canvas.drawPath(Path()..moveTo(size.width - cornerLength, 0)..lineTo(size.width, 0)..lineTo(size.width, cornerLength), paint);
    // Bottom Left
    canvas.drawPath(Path()..moveTo(0, size.height - cornerLength)..lineTo(0, size.height)..lineTo(cornerLength, size.height), paint);
    // Bottom Right
    canvas.drawPath(Path()..moveTo(size.width - cornerLength, size.height)..lineTo(size.width, size.height)..lineTo(size.width, size.height - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}