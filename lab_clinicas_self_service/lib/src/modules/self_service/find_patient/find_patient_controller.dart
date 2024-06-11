// ignore_for_file: unnecessary_this

// ignore_for_file: dead_code

import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {
  final PatientRepository _repository;

  FindPatientController({required PatientRepository repository}) 
      : _repository = repository;

  final _patientNotFound = ValueSignal<bool?>(null);
  bool? get patientNotFound => _patientNotFound();

  final _patient = ValueSignal<PatientModel?>(null);
  PatientModel? get patient => _patient();

  Future<void> findPatientByDocument(String cpf) async {
    final result = await _repository.findPatientByDocument(cpf);
    bool patientNotFound = false;
    PatientModel? patient;

    switch (result) {
      case Right(value: PatientModel model?):
        patientNotFound = false; 
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError("Error trying to reach patient.");
        return;
    }

    batch(
      () {
        _patient.forceUpdate(patient);
        _patientNotFound.forceUpdate(patientNotFound);
      },
    );
  }

  void continueWithoutDocument() {
    batch(
      () {
        _patient.value = patient;
        _patientNotFound.forceUpdate(true);
      },
    );
  }
}
