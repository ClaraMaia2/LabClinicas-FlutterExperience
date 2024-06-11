import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class DocumentsBoxWidget extends StatelessWidget {
  const DocumentsBoxWidget(
      {super.key,
      required this.uploaded,
      required this.icon,
      required this.labels,
      required this.filesTotal,
      this.onTap});

  final bool uploaded;
  final Widget icon;
  final String labels;
  final int filesTotal;
  final VoidCallback? onTap;
 
  @override
  Widget build(BuildContext context) {
    final fileLabelTotal = filesTotal > 0 ? '($filesTotal)' : '';

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: uploaded ? LabClinicasTheme.lightOrangeColor : Colors.white,
            border: Border.all(
              color: LabClinicasTheme.orangeColor,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: icon,
              ),
              Text(
                "$labels $fileLabelTotal ",
                style: const TextStyle(
                  fontSize: 15,
                  color: LabClinicasTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
