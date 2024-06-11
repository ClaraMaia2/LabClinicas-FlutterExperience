import 'package:flutter/material.dart';
import 'package:lab_clinicas_core/lab_clinicas_core.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_desktop/src/models/patient_information_form_model.dart';
import 'package:lab_clinicas_desktop/src/pages/checkin/checkin_controller.dart';
import 'package:lab_clinicas_desktop/src/shared/data_item.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'widgets/checkin_image_link.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessageViewMixin {
  final controller = Injector.get<CheckinController>();
  @override
  void initState() {
    messageListener(controller);

    effect(
      () {
        if (controller.endProcess()) {
          Navigator.of(context).pushReplacementNamed('/end-checkin');
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.of(context).size;

    final PatientInformationFormModel(
      :password,
      :patient,
      :medicalOrder,
      :healthInsuranceCard
    ) = controller.informationForm.watch(context)!;

    return Scaffold(
      appBar: LabClinicasAppbar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: sizeOf.width * 0.5,
            margin: const EdgeInsets.only(
              top: 45,
            ),
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
                  "The password passed",
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
                  ),
                ),
                const SizedBox(
                  height: 46,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.lightOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Registration",
                    style: LabClinicasTheme.subtitleSmallStyle.copyWith(
                      color: LabClinicasTheme.orangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                      '${patient.address.streetAddress}, ${patient.address.number}, ${patient.address.addressComplement},${patient.address.city}, ${patient.address.state}, ${patient.address.district},',
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
                  label: "Guardian's Identification",
                  value: patient.guardianIdentificationNumber,
                  padding: const EdgeInsets.only(
                    bottom: 15,
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.lightOrangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Validate Health Insurance Card and Medical Orders",
                    style: LabClinicasTheme.subtitleSmallStyle.copyWith(
                        color: LabClinicasTheme.orangeColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                      label: 'Health Insurance Card',
                      image: healthInsuranceCard,
                    ),
                    Column(
                      children: [
                        CheckinImageLink(
                          label: "Medical Order",
                          image: medicalOrder,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.endCheckIn();
                        },
                        child: const Text(
                          "END SERVICE",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
