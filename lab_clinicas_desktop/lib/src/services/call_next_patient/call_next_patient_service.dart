// ignore_for_file: dead_code

import 'dart:developer';

import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_desktop/src/repositories/attendant_desk/desk_assignment.dart';
import 'package:lab_clinicas_desktop/src/repositories/panel/panel_repository.dart';
import 'package:lab_clinicas_desktop/src/repositories/patient_information_form/patient_information_form_repository.dart';

class CallNextPatientService {
  CallNextPatientService({
    required this.patientInformationFormRepository,
    required this.deskAssignmentRepository,
    required this.panelRepository,
  });

  final PatientInformationFormRepository patientInformationFormRepository;
  final DeskAssignmentRepository deskAssignmentRepository;
  final PanelRepository panelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await patientInformationFormRepository.callNextToCheckIn();

    switch (result) {
      case Left(value: final ex):
        return Left(ex);
      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel form) async {
    final deskResult = await deskAssignmentRepository.getDeskAssignment();

    switch (deskResult) {
      case Left(value: final ex):
        return Left(ex);
      case Right(value: final deskNumber):
        final panelResult = await panelRepository.callOnPanel(
          form.password,
          deskNumber,
        );

        switch (panelResult) {
          case Left(value: final ex):
            log(
              "Error trying to call patient to the panel",
              error: ex,
              stackTrace: StackTrace.fromString(
                "Error trying to call patient to the panel",
              ),
            );

            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
