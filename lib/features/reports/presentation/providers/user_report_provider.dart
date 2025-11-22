import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mapa de Líneas del Metro CDMX con estaciones
const Map<String, List<String>> metroCDMX = {
  "Línea 1 : Rosa": [ "Pantitlán", "Zaragoza", "Gómez Farías", "Boulevard Puerto Aéreo", "Balbuena", "Moctezuma", "San Lázaro", "Candelaria", "Merced", "Pino Suárez", "Isabel la Católica", "Salto del Agua", "Balderas", "Cuauhtémoc", "Insurgentes", "Sevilla", "Chapultepec", "Juanacatlán", "Tacubaya", "Observatorio" ],
  "Línea 2 : Azul": [ "Cuatro Caminos", "Panteones", "Tacuba", "Cuitláhuac", "Popotla", "Colegio Militar", "Normal", "San Cosme", "Revolución", "Hidalgo", "Bellas Artes", "Allende", "Zócalo/Tenochtitlan", "Pino Suárez", "San Antonio Abad", "Chabacano", "Viaducto", "Xola", "Villa de Cortés", "Nativitas", "Portales", "Ermita", "General Anaya", "Tasqueña" ],
  "Línea 3 : Verde": [ "Indios Verdes", "Deportivo 18 de Marzo", "La Raza", "Potrero", "Autobuses del Norte", "Instituto del Petróleo", "Vallejo", "Guerrero", "Hidalgo", "Juárez", "Balderas", "Niños Héroes", "Hospital General", "Centro Médico", "Etiopía-Plaza de la Transparencia", "Eugenia", "División del Norte", "Zapata", "Coyoacán", "Viveros/Derechos Humanos", "Miguel Ángel de Quevedo", "Copilco", "Universidad" ],
  "Línea 4 : Aqua": [ "Martín Carrera", "Talismán", "Bondojito", "Consulado", "Canal del Norte", "Morelos", "Candelaria", "Fray Servando", "Jamaica", "Santa Anita" ],
  "Línea 5 : Amarilla": [ "Pantitlán", "Hangares", "Terminal Aérea", "Oceanía", "Aragón", "Eduardo Molina", "Consulado", "Valle Gómez", "Misterios", "La Raza", "Autobuses del Norte", "Instituto del Petróleo", "Politécnico" ],
  "Línea 6 : Roja": [ "El Rosario", "Tezozómoc", "UAM-Azcapotzalco", "Ferrería/Arena Ciudad de México", "Norte 45", "Vallejo", "Instituto del Petróleo", "Lindavista", "Deportivo 18 de Marzo", "La Villa-Basílica", "Martín Carrera" ],
  "Línea 7 : Naranja": [ "El Rosario", "Aquiles Serdán", "Camarones", "Refinería", "Tacuba", "San Joaquín", "Polanco", "Auditorio", "Constituyentes", "Tacubaya", "San Pedro de los Pinos", "San Antonio", "Mixcoac", "Barranca del Muerto" ],
  "Línea 8 : Verde Bandera": [ "Garibaldi-Lagunilla", "Bellas Artes", "San Juan de Letrán", "Salto del Agua", "Doctores", "Obrera", "Chabacano", "La Viga", "Santa Anita", "Coyuya", "Iztacalco", "Aculco", "Escuadrón 201", "Atlalilco", "Iztapalapa", "Cerro de la Estrella", "UAM-I", "Constitución de 1917" ],
  "Línea 9 : Café": [ "Pantitlán", "Puebla", "Agrícola Oriental", "Velódromo", "Mixiuhca", "Jamaica", "Chabacano", "Lázaro Cárdenas", "Centro Médico", "Etiopía-Plaza de la Transparencia" ],
  "Línea A : Morada": [ "Pantitlán", "Agrícola Oriental", "Canal de San Juan", "Tepalcates", "Guelatao", "Peñón Viejo", "Acatitla", "Santa Marta", "Los Reyes", "La Paz" ],
  "Línea B : Verde y Gris": [ "Buenavista", "Guerrero", "Garibaldi-Lagunilla", "Bellas Artes", "San Lázaro", "Ricardo Flores Magón", "Romero Rubio", "Oceanía", "Deportivo Oceanía", "Bosque de Aragón", "Villa de Aragón", "Nezahualcóyotl", "Impulsora", "Río de los Remedios", "Múzquiz", "Ecatepec", "Olímpica", "Plaza Aragón", "Ciudad Azteca" ],
  "Línea 12 : Dorada": [ "Tláhuac", "Tlaltenco", "Zapotitlán", "Nopalera", "Olivos", "Tezonco", "Periférico Oriente", "Calle 11", "Lomas Estrella", "San Andrés Tomatlán", "Culhuacán", "Atlalilco", "Mexicaltzingo", "Ermita", "Eje Central", "Parque de los Venados", "Zapata", "Hospital 20 de Noviembre", "Insurgentes Sur", "Mixcoac" ]
};

// 1. Entidad del Estado (Inmutable)
class ReportFormState {
  final bool isCurrentTime;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String incidentType;
  final String description;
  final String severity; // 'Leve', 'Medio', 'Grave'
  final String line; // Nombre completo de la línea seleccionada
  final String station;
  final String gpsLocation; // Hardcodeado por ahora

  const ReportFormState({
    this.isCurrentTime = true,
    required this.selectedDate,
    required this.selectedTime,
    this.incidentType = 'Retraso',
    this.description = '',
    this.severity = 'Leve',
    required this.line,
    required this.station,
    this.gpsLocation = '19.4326, -99.1332', // CDMX Zócalo Hardcode
  });

  // Getter para obtener la lista de todas las líneas disponibles
  List<String> get availableLines => metroCDMX.keys.toList();

  // Getter para obtener las estaciones de la línea actualmente seleccionada
  List<String> get availableStations => metroCDMX[line] ?? [];

  ReportFormState copyWith({
    bool? isCurrentTime,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? incidentType,
    String? description,
    String? severity,
    String? line,
    String? station,
  }) {
    return ReportFormState(
      isCurrentTime: isCurrentTime ?? this.isCurrentTime,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      incidentType: incidentType ?? this.incidentType,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      line: line ?? this.line,
      station: station ?? this.station,
      gpsLocation: this.gpsLocation,
    );
  }
}

// 2. Notifier (Lógica)
class ReportFormNotifier extends AutoDisposeNotifier<ReportFormState> {
  @override
  ReportFormState build() {
    // Inicializamos con la primera línea disponible y su primera estación
    final initialLine = metroCDMX.keys.first;
    
    return ReportFormState(
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
      line: initialLine,
      station: metroCDMX[initialLine]!.first,
    );
  }

  void toggleCurrentTime(bool? value) {
    state = state.copyWith(isCurrentTime: value ?? true);
  }

  void updateDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateTime(TimeOfDay time) {
    state = state.copyWith(selectedTime: time);
  }

  void updateIncidentType(String? type) {
    if (type != null) state = state.copyWith(incidentType: type);
  }

  void updateDescription(String text) {
    state = state.copyWith(description: text);
  }

  void updateSeverity(String severity) {
    state = state.copyWith(severity: severity);
  }

  // Lógica para actualizar la línea y resetear la estación
  void updateLine(String? newLine) {
    if (newLine != null && metroCDMX.containsKey(newLine)) {
      // 1. Obtener la primera estación de la nueva línea
      final newStation = metroCDMX[newLine]!.first;
      
      // 2. Actualizar la línea y la estación al mismo tiempo
      state = state.copyWith(
        line: newLine,
        station: newStation,
      );
    }
  }

  // Lógica para actualizar la estación
  void updateStation(String? newStation) {
    if (newStation != null) {
      state = state.copyWith(station: newStation);
    }
  }

  void submitReport() {
    // Aquí se imprimirán los datos finales
    print("--- ENVIANDO REPORTE ---");
    print("Fecha Actual: ${state.isCurrentTime}");
    print("Momento: ${state.selectedDate} ${state.selectedTime}");
    print("Ubicación GPS: ${state.gpsLocation}");
    print("Línea: ${state.line} (Opcional: ${!state.isCurrentTime})");
    print("Estación: ${state.station}");
    print("Tipo: ${state.incidentType}");
    print("Severidad: ${state.severity}");
    print("Descripción: ${state.description}");
    print("------------------------");
  }
}

// 3. Provider Global
final reportFormProvider =
    NotifierProvider.autoDispose<ReportFormNotifier, ReportFormState>(
  ReportFormNotifier.new,
);