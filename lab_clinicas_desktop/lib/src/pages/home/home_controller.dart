import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_desktop/src/repositories/attendant_desk/desk_assignment.dart';
import 'package:lab_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:asyncstate/asyncstate.dart' as asyncstate;

class HomeController with MessageStateMixin {
  HomeController({
    required DeskAssignmentRepository deskAssignmentRepository,
    required CallNextPatientService callNextPatientService,
  })  : _deskAssignmentRepository = deskAssignmentRepository,
        _callNextPatientService = callNextPatientService;

  final DeskAssignmentRepository _deskAssignmentRepository;
  final CallNextPatientService _callNextPatientService;
  final _informationForm = signal<PatientInformationFormModel?>(null);
  PatientInformationFormModel? get informationForm => _informationForm();

  Future<void> startService(int deskNumber) async {
    asyncstate.AsyncState.show();

    final result = await _deskAssignmentRepository.startService(deskNumber);

    switch (result) {
      case Left():
        asyncstate.AsyncState.hide();
        showError("Error trying to initiate window");
      case Right(value: _):
        final nextPatientResult = await _callNextPatientService.execute();

        switch (nextPatientResult) {
          case Left():
            showError("Error trying to call next patient");
          case Right(value: final form?):
            asyncstate.AsyncState.hide();
            _informationForm.value = form;
          case Right(value: _):
            asyncstate.AsyncState.hide();
            showInfo("There are no patients in line to be called");
        }
    }
  }
}
