import 'package:lab_clinicas_core/lab_clinicas_core.dart';

import 'package:lab_clinicas_desktop/src/core/env.dart';
import 'package:lab_clinicas_desktop/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:flutter_getit/flutter_getit.dart';

import '../repositories/attendant_desk/desk_assignment.dart';
import '../repositories/attendant_desk/desk_assignment_impl.dart';
import '../repositories/panel/panel_repository.dart';
import '../repositories/panel/panel_repository_impl.dart';
import '../repositories/patient_information_form/patient_information_form_repository.dart';
import '../repositories/patient_information_form/patient_information_form_repository_impl.dart';

class LabClinicasAppBinding extends ApplicationBindings {
  @override
  List<Bind<Object>> bindings() => [
        Bind.lazySingleton(
          (i) => RestClient(Env.backEndBaseURL),
        ),
        Bind.lazySingleton<PatientInformationFormRepository>(
          (i) => PatientInformationFormRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton<DeskAssignmentRepository>(
          (i) => DeskAssignmentRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton<PanelRepository>(
          (i) => PanelRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton(
          (i) => CallNextPatientService(
            patientInformationFormRepository: i(),
            deskAssignmentRepository: i(),
            panelRepository: i(),
          ),
        ),
      ];
}
