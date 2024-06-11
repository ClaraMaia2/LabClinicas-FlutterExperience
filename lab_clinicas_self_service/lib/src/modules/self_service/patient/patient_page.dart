
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/patient/patient_form_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/widgets/lab_clinicas_self_service_appbar.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with PatientFormController, MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final selfServiceController = Injector.get<SelfServiceController>();
  final PatientController controller = Injector.get<PatientController>();

  late bool patientFound;
  late bool enableForm;

  @override
  void initState() {
    messageListener(controller);

    final SelfServiceModel(:patient) = selfServiceController.model;

    patientFound = patient != null;
    enableForm = !patientFound;

    initializeForm(patient);

    effect(
      () {
        if (controller.nextStep) {
          selfServiceController.updatePatientAndGoDocument(controller.patient);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 18,
            ),
            padding: const EdgeInsets.all(32),
            width: sizeOf.width * 0.85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: patientFound,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      "Registration couldn't be found",
                      style: LabClinicasTheme.titleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                    child: const Text(
                      "Registration found",
                      style: LabClinicasTheme.titleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      "Fill up the form to continue",
                      style: LabClinicasTheme.subtitleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                    child: const Text(
                      "Confirm the registred data",
                      style: LabClinicasTheme.subtitleSmallStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    validator: Validatorless.required("Patient's name"),
                    decoration: const InputDecoration(
                      labelText: "Patient's name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    validator: Validatorless.multiple(
                      [
                        Validatorless.required("Email required"),
                        Validatorless.email("Invalid email"),
                      ],
                    ),
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: phoneEC,
                    validator: Validatorless.required("Phone required"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: Validatorless.required("CPF required"),
                    decoration: const InputDecoration(
                      labelText: "CPF",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: cepEC,
                    validator: Validatorless.required("CEP required"),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: "CEP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: streetAddressEC,
                          validator: Validatorless.required("Address required"),
                          decoration: const InputDecoration(
                            labelText: "Address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: numberEC,
                          validator: Validatorless.required("Number required"),
                          decoration: const InputDecoration(
                            labelText: "No",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: complementEC,
                          decoration: const InputDecoration(
                            labelText: "Complement",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: stateEC,
                          validator: Validatorless.required("UF required"),
                          decoration: const InputDecoration(
                            labelText: "UF",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: cityEC,
                          validator: Validatorless.required("City required"),
                          decoration: const InputDecoration(
                            labelText: "City",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: districtEC,
                          validator:
                              Validatorless.required("District required"),
                          decoration: const InputDecoration(
                            labelText: "District",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    decoration: const InputDecoration(
                      labelText: "Guardian",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumberEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      labelText: "Guardian's Identification Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          final validForm =
                              formKey.currentState?.validate() ?? false;

                          if (validForm) {
                            if (patientFound) {
                              controller.updateAndNext(
                                updatePatient(
                                    selfServiceController.model.patient!),
                              );
                            } else {
                              controller
                                  .registerAndNext(createPatientRegister());
                            }
                          }
                        },
                        child: Visibility(
                          visible: !patientFound,
                          replacement: const Text("SAVE CHANGES AND CONTINUE"),
                          child: const Text(
                            "REGISTER",
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    enableForm = true;
                                  },
                                );
                              },
                              child: const Text(
                                "EDIT",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                final validForm =
                                    formKey.currentState?.validate() ?? false;

                                if (validForm) {
                                  controller.patient =
                                      selfServiceController.model.patient;
                                  controller.goNextStep();
                                }
                              },
                              child: const Text(
                                "CONTINUE",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
