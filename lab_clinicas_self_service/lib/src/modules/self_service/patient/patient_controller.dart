// ignore_for_file: unnecessary_this

import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  PatientController({required PatientRepository patientRepository})
      : _patientRepository = patientRepository;

  final PatientRepository _patientRepository;
  PatientModel? patient;

  final _nextStep = signal<bool>(false);
  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> updateAndNext(PatientModel model) async {
    final updateResult = await _patientRepository.update(model);

    switch (updateResult) {
      case Left():
        showError("Error trying to update patient's data");
      case Right():
        showInfo("Patient's data updated successfully!");
        patient = model;
        goNextStep();
    }
  }

  Future<void> registerAndNext(RegisterPatientModel model) async {
    final registerResult = await _patientRepository.register(model);

    switch (registerResult) {
      case Right(value: final patient):
        showSuccess("Patient registered successfully!");
        this.patient = patient;
        goNextStep();
      case Left():
        showError("Error trying to register patient");
    }
  }
}