import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/bindings/lab_clinicas_app_binding.dart';
import 'package:lab_clinicas_desktop/src/pages/checkin/checkin_router.dart';
import 'package:lab_clinicas_desktop/src/pages/end_checkin/end_checkin_router.dart';
import 'package:lab_clinicas_desktop/src/pages/home/home_router.dart';
import 'package:lab_clinicas_desktop/src/pages/login/login_router.dart';
import 'package:lab_clinicas_desktop/src/pages/pre_checkin/pre_checkin_router.dart';
import 'package:lab_clinicas_desktop/src/pages/splash/splash_page.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
    },
    (error, stack) {
      log(
        "NOT TREATED ERROR",
        error: error,
        stackTrace: stack,
      );

      throw error;
    },
  );
}

class LabClinicasADM extends StatelessWidget {
  const LabClinicasADM({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: "Clinic's Administrator",
      pagesBuilders: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: '/')
      ],
      bindings: LabClinicasAppBinding(),
      pages: const [
        LoginRouter(),
        HomeRouter(),
        PreCheckinRouter(),
        CheckinRouter(),
        EndCheckinRouter(),
      ],
    );
  }
}
