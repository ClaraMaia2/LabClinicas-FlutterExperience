import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';

abstract interface class PatientInformationFormRepository {
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCheckIn();

  Future<Either<RepositoryException, Unit>> updateStatus(
      String id, PatientInformationFormStatus status);
}
