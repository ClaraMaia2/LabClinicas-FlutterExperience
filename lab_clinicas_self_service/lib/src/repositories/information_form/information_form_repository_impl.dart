import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';

class InformationFormRepositoryImpl implements InformationFormRepository {
  InformationFormRepositoryImpl({required this.restClient});

  final RestClient restClient;

  @override
  Future<Either<RepositoryException, Unit>> register(
      SelfServiceModel model) async {
    try {
      final SelfServiceModel(
        :firstName!,
        :lastName!,
        patient: PatientModel(id: patientId)!,
        documents: {
          DocumentType.carteirinha: List(first: carteirinhaDoc),
          DocumentType.pedidoMedico: List(first: pedidoMedicoDoc),
        }!
      ) = model;

      await restClient.auth.post(
        '/patientInformationForm',
        data: {
          'patient_id': patientId,
          'health_insurance_card': carteirinhaDoc,
          'medical_order': pedidoMedicoDoc,
          'password': "$firstName $lastName",
          'date_created': DateTime.now().toIso8601String(),
          'status': "Waiting",
          'tests': [],
        },
      );

      return Right(unit);
    } on DioException catch (e, s) {
      log(
        "Error trying to register the information form",
        error: e,
        stackTrace: s,
      );

      return Left(RepositoryException());
    }
  }
}
