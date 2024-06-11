import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';

class PasswordTileWidget extends StatelessWidget {
  const PasswordTileWidget({
    super.key,
    required this.password,
    required this.deskNumber,
  });

  final String password;
  final String deskNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: LabClinicasTheme.orangeColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            password,
            style: const TextStyle(
              color: LabClinicasTheme.blueColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            "Window $deskNumber",
            style: const TextStyle(
              color: LabClinicasTheme.orangeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
