import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/documents/documents_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/documents/scan/documents_scan_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/documens_scan_confirm_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/done/done_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/find_patient/find_patient_router.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/patient/patient_router.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/self_service_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/who_am_i/who_am_i_page.dart';
import 'package:lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:lab_clinicas_self_service/src/repositories/patients/patient_repository_impl.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => SelfServiceController()),
        Bind.lazySingleton<PatientRepository>(
            (i) => PatientRepositoryImpl(restClient: i())),
      ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/whoAmI': (context) => const WhoAmI(),
        '/findPatient': (context) => const FindPatientRouter(),
        '/patient': (context) => const PatientRouter(),
        '/documents': (context) => const DocumentsPage(),
        '/documents/scan': (context) => const DocumentsScanPage(),
        '/documents/scan-confirm': (context) => DocumentsScanConfirmPage(),
        '/done': (context) => const DonePage(),
      };
}
