import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/pages/end_checkin/end_checkin_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';

class EndCheckinPage extends StatefulWidget {
  const EndCheckinPage({super.key});

  @override
  State<EndCheckinPage> createState() => _EndCheckinPageState();
}

class _EndCheckinPageState extends State<EndCheckinPage> with MessageViewMixin {
  final controller = Injector.get<EndCheckinController>();

  @override
  void initState() {
    messageListener(controller);

    effect(
      () {
        if (controller.informationForm() != null) {
          Navigator.of(context).pushReplacementNamed(
            '/pre-checkin',
            arguments: controller.informationForm(),
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(40),
          margin: EdgeInsets.only(
            top: sizeOf.height * 0.1,
          ),
          constraints: BoxConstraints(
            maxWidth: sizeOf.width * 0.45,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: LabClinicasTheme.orangeColor,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/check_icon.png'),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Appointment concluded successfully",
                style: LabClinicasTheme.titleSmallStyle,
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    controller.callNextPatient();
                  },
                  child: const Text(
                    "CALL NEXT CODE",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
