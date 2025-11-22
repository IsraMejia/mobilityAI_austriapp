import 'package:austriapp/core/theme/app_colors.dart';
import 'package:austriapp/features/map/presentation/widgets/navigation_menu_drawer.dart';
import 'package:austriapp/features/reports/presentation/providers/user_report_provider.dart';
import 'package:austriapp/features/reports/presentation/widgets/report_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class UserReportScreen extends ConsumerWidget {
  const UserReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportFormProvider);
    final notifier = ref.read(reportFormProvider.notifier);

    // Lista de tipos de incidencia
    final incidentTypes = [
      'Retraso',
      'Falla Mecánica',
      'Seguridad',
      'Aglomeración',
      'Obstrucción de Vías',
      'Otro'
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar( 
        backgroundColor: Colors.black.withOpacity(0.9),  
        surfaceTintColor: Colors.transparent,  
        scrolledUnderElevation: 0,  
        iconTheme: const IconThemeData(color: AppColors.neonGreen),
      ),
      drawer: const NavigationMenuDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculamos el 40% de la altura disponible para la descripción
          final descriptionHeight = constraints.maxHeight * 0.4;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Encabezado
                const ReportHeaderWidget(),
                const Divider(color: Colors.grey, height: 30),

                // 2. Checkbox: Reportar ahora
                _buildTimeLocationToggle(reportState, notifier, context),
                const SizedBox(height: 20),

                // 3. Campos Condicionales (Línea/Estación/Fecha)
                if (!reportState.isCurrentTime) ...[
                  _buildManualDateTimePickers(context, reportState, notifier),
                  const SizedBox(height: 20),
                ],

                Row(
                  children: [
                    // --- Selector de Línea (Dropdown) ---
                    Expanded(
                      child: NeonDropdown<String>(
                        label: 'Línea',
                        value: reportState.line,
                        items: reportState.availableLines, // Obtenida del getter del estado
                        isMandatory: !reportState.isCurrentTime,
                        onChanged: notifier.updateLine,
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // --- Selector de Estación (Dropdown) ---
                    Expanded(
                      child: NeonDropdown<String>(
                        label: 'Estación',
                        value: reportState.station,
                        // Obtenida del getter del estado, depende de la línea
                        items: reportState.availableStations, 
                        isMandatory: !reportState.isCurrentTime,
                        onChanged: notifier.updateStation,
                      ),
                    ),
                  ],
                ),



                const SizedBox(height: 20),

                // 4. Tipo de Incidente (Dropdown)
                Text(
                  'Tipo de Incidente *',
                  style: TextStyle(color: AppColors.neonGreen, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade800),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: reportState.incidentType,
                      dropdownColor: Colors.grey.shade900,
                      isExpanded: true,
                      style: const TextStyle(color: Colors.white),
                      items: incidentTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: notifier.updateIncidentType,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Severidad
                const Text('Severidad', style: TextStyle(color: AppColors.neonGreen)),
                const SizedBox(height: 8),
                SeveritySelector(
                  currentSeverity: reportState.severity,
                  onSelected: notifier.updateSeverity,
                ),
                const SizedBox(height: 20),

                // 6. Descripción (40% Altura)
                NeonTextField(
                  label: 'Descripción del suceso *',
                  hint: 'Detalla lo ocurrido...',
                  isMandatory: true,
                  maxLines: 20, // Suficiente para activar scroll interno
                  height: descriptionHeight,
                  onChanged: notifier.updateDescription,
                ),
                // Contador de caracteres
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${reportState.description.length} caracteres',
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 7. Botones (Evidencia y Enviar)
                _buildEvidenceButton(),
                const SizedBox(height: 20),
                _buildSubmitButton(notifier, context),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Sub-widgets privados para organizar el build ---

  Widget _buildTimeLocationToggle(
      ReportFormState state, ReportFormNotifier notifier, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: state.isCurrentTime ? AppColors.neonGreen : Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: state.isCurrentTime
            ? AppColors.neonGreen.withOpacity(0.1)
            : Colors.transparent,
      ),
      child: CheckboxListTile(
        title: const Text(
          "Reportar en este momento",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          state.isCurrentTime
              ? "Ubicación GPS activada (Automática)"
              : "Ingresar fecha y ubicación manual",
          style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
        ),
        value: state.isCurrentTime,
        activeColor: AppColors.neonGreen,
        checkColor: Colors.black,
        contentPadding: EdgeInsets.zero,
        onChanged: notifier.toggleCurrentTime,
      ),
    );
  }

  Widget _buildManualDateTimePickers(
      BuildContext context, ReportFormState state, ReportFormNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today, color: AppColors.neonGreen),
            label: Text(
              "${state.selectedDate.day}/${state.selectedDate.month}/${state.selectedDate.year}",
              style: const TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: state.selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (date != null) notifier.updateDate(date);
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.access_time, color: AppColors.neonGreen),
            label: Text(
              state.selectedTime.format(context),
              style: const TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.grey),
            ),
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: state.selectedTime,
              );
              if (time != null) notifier.updateTime(time);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEvidenceButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
        label: const Text("Adjuntar Evidencia (Max 3)", style: TextStyle(color: Colors.white)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: const BorderSide(color: Colors.white30, style: BorderStyle.solid ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          print("Abrir selector de fotos");
        },
      ),
    );
  }

  Widget _buildSubmitButton(ReportFormNotifier notifier, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonGreen,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          notifier.submitReport();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Reporte enviado (Revisa la consola)'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
            ),
          );
          // Opcional: Volver al mapa
          // context.router.pop();
        },
        child: const Text(
          "ENVIAR REPORTE",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}