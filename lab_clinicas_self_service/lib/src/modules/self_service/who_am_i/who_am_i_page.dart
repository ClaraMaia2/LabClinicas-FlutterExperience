import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/find_patient/find_patient_page.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoAmI extends StatefulWidget {
  const WhoAmI({super.key});

  @override
  State<WhoAmI> createState() => _WhoAmIState();
}

class _WhoAmIState extends State<WhoAmI> {
  final selfServiceController = Injector.get<SelfServiceController>();

  final formKey = GlobalKey<FormState>();
  final firstNameEC = TextEditingController();
  final lastNameEC = TextEditingController();

  @override
  void dispose() {
    firstNameEC.dispose();
    lastNameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        firstNameEC.text = '';
        lastNameEC.text = '';
        selfServiceController.clearForm();
      },
      child: Scaffold(
        appBar: LabClinicasAppbar(
          actions: [
            PopupMenuButton(
              child: const IconPopupMenuWidget(),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Finish Terminal"),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 1) {
                  final nav = Navigator.of(context);

                  await SharedPreferences.getInstance()
                      .then((sp) => sp.clear());

                  nav.pushNamedAndRemoveUntil('/', (route) => false);
                }
              },
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (_, contraints) {
            var sizeOf = MediaQuery.sizeOf(context);

            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: contraints.maxHeight,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    width: sizeOf.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo_vertical.png',
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          const Text(
                            "Welcome!",
                            style: LabClinicasTheme.subtitleSmallStyle,
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          TextFormField(
                            controller: firstNameEC,
                            validator:
                                Validatorless.required("First Name required"),
                            decoration: const InputDecoration(
                              label: Text(
                                "First Name",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: lastNameEC,
                            validator:
                                Validatorless.required("Last Name Required"),
                            decoration: const InputDecoration(
                              label: Text(
                                "Last Name",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            width: sizeOf.width * 0.8,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                final valid =
                                    formKey.currentState?.validate() ?? false;

                                if (valid) {
                                  selfServiceController
                                      .setWhoAmIDataStepAndNext(
                                    firstNameEC.text,
                                    lastNameEC.text,
                                  );

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const FindPatientPage();
                                      },
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                "CONTINUE",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
