// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/pages/home/home_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final windowEC = TextEditingController();
  final controller = Injector.get<HomeController>();

  @override
  void initState() {
    messageListener(controller);

    effect(
      () {
        if (controller.informationForm != null) {
          print("PATIENT LOADED!");

          Navigator.of(context).pushReplacementNamed(
            '/pre-checkin',
            arguments: controller.informationForm,
          );
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    windowEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(34),
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
                const Text(
                  "Welcome!",
                  style: LabClinicasTheme.titleStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Fill up the field with the Window's number",
                  style: LabClinicasTheme.subtitleSmallStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: windowEC,
                  validator: Validatorless.multiple(
                    [
                      Validatorless.required("Required field"),
                      Validatorless.number("Only numbers"),
                    ],
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: "Window's number",
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final valid = formKey.currentState?.validate() ?? false;

                      if (valid) {
                        controller.startService(
                          int.parse(windowEC.text),
                        );
                      }
                    },
                    child: const Text(
                      "CALL NEXT PATIENT",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
