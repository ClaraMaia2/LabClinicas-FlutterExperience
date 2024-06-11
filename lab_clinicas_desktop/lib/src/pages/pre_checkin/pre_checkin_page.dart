import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_desktop/src/pages/pre_checkin/pre_checkin_controller.dart';
import 'package:lab_clinicas_desktop/src/shared/data_item.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PreCheckinPage extends StatefulWidget {
  const PreCheckinPage({super.key});

  @override
  State<PreCheckinPage> createState() => _PreCheckinPageState();
}

class _PreCheckinPageState extends State<PreCheckinPage> with MessageViewMixin {
  final controller = Injector.get<PreCheckinController>();

  @override
  void initState() {
    messageListener(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;
    final PatientInformationFormModel(:password, :patient) =
        controller.informationForm.watch(context)!;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: sizeOf.width * 0.5,
            margin: const EdgeInsets.only(top: 45),
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: LabClinicasTheme.orangeColor,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/patient_avatar.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "The password is correct",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 22,
                  ),
                  width: sizeOf.width * 0.12,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    password,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                DataItem(
                  label: "Patient's name",
                  value: patient.name,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "E-mail",
                  value: patient.email,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "Phone",
                  value: patient.phoneNumber,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "CPF",
                  value: patient.document,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "CEP",
                  value: patient.address.cep,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "Address",
                  value:
                      '${patient.address.streetAddress}, ${patient.address.number}, ${patient.address.addressComplement}, ${patient.address.city}, ${patient.address.state}, ${patient.address.district}',
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "Guardian",
                  value: patient.guardian,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                DataItem(
                  label: "Guardian's identification",
                  value: patient.guardianIdentificationNumber,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          controller.next();
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          "CALL NEXT PATIENT",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                            '/checkin',
                            arguments: controller.informationForm.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          "ATTEND",
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
