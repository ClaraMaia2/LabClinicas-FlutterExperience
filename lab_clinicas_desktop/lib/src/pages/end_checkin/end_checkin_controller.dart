import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckinController with MessageStateMixin {
  EndCheckinController({
    required CallNextPatientService callNextPatientService,
  }) : _callNextPatientService = callNextPatientService;

  final CallNextPatientService _callNextPatientService;
  final informationForm = signal<PatientInformationFormModel?>(null);

  Future<void> callNextPatient() async {
    final result = await _callNextPatientService.execute();

    switch (result) {
      case Left():
        showError("Error trying to call the next code");
      case Right(value: final form?):
        informationForm.value = form;
      case _:
        showInfo("No code to call");
    }
  }
}
