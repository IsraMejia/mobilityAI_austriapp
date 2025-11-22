import 'package:austriapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// --- Header con Fecha ---
class ReportHeaderWidget extends StatelessWidget {
  const ReportHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Reportar Incidente',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${now.day}/${now.month}/${now.year}',
              style: const TextStyle(color: AppColors.neonGreen, fontSize: 14),
            ),
            Text(
              '${now.hour}:${now.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}

// --- Selector de Severidad (Chips) ---
class SeveritySelector extends StatelessWidget {
  final String currentSeverity;
  final Function(String) onSelected;

  const SeveritySelector({
    super.key,
    required this.currentSeverity,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const options = ['Leve', 'Medio', 'Grave'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: options.map((severity) {
        final isSelected = currentSeverity == severity;
        Color color;
        if (severity == 'Leve') color = Colors.yellow;
        else if (severity == 'Medio') color = Colors.orange;
        else color = Colors.red;

        return Expanded(
          child: GestureDetector(
            onTap: () => onSelected(severity),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? color : Colors.grey.shade800,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  severity,
                  style: TextStyle(
                    color: isSelected ? color : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// --- Dropdown Estilo Neón ---
class NeonDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final bool isMandatory;
  final String? hintText;
  final Function(T?) onChanged;

  const NeonDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isMandatory = false,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(color: AppColors.neonGreen, fontSize: 14),
            children: [
              if (isMandatory)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
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
            child: DropdownButton<T>(
              value: value,
              hint: hintText != null 
                    ? Text(hintText!, style: TextStyle(color: Colors.grey.shade600)) 
                    : null,
              dropdownColor: Colors.grey.shade900,
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.neonGreen),
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(), 
                    style: const TextStyle(color: Colors.white)
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

// --- Input Genérico Estilo Neón ---
class NeonTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isMandatory;
  final int maxLines;
  final double? height;
  final Function(String) onChanged;

  const NeonTextField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint,
    this.isMandatory = false,
    this.maxLines = 1,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(color: AppColors.neonGreen, fontSize: 14),
            children: [
              if (isMandatory)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade800),
          ),
          child: TextField(
            maxLines: maxLines,
            style: const TextStyle(color: Colors.white),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }
}