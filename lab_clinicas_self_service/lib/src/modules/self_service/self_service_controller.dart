// ignore_for_file: prefer_final_fields, avoid_print

import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoAmI,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  var password = '';
  late final InformationFormRepository informationFormRepository;

  FormSteps get step => _step();
  SelfServiceModel get model => _model;

  void startProcess() {
    _step.forceUpdate(FormSteps.whoAmI);
  }

  void setWhoAmIDataStepAndNext(String firstName, String lastName) {
    _model = _model.copyWith(
      firstName: () => firstName,
      lastName: () => lastName,
    );

    _step.forceUpdate(FormSteps.findPatient);
  }

  void debug() {
    print(_model.firstName);
    print(_model.lastName);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);

    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);

    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patient) {
    _model = model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};

    if (type == DocumentType.carteirinha) {
      documents[type]?.clear();
    }

    final values = documents[type] ?? [];

    values.add(filePath);
    documents[type] = values;
    _model = _model.copyWith(
      documents: () => documents,
    );
  }

  void clearDocuments() {
    _model = _model.copyWith(
      documents: () => {},
    );
  }

  Future<void> finalize() async {
    final result =
        await informationFormRepository.register(_model).asyncLoader();

    switch (result) {
      case Right():
        password = "${_model.firstName} ${_model.lastName}";
        _step.forceUpdate(FormSteps.done);
      case Left():
        showError("Error trying to end the program");
    }
  }
}
