import 'package:flutter/material.dart';
import 'package:lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:lab_clinicas_self_service/src/modules/self_service/patient/patient_page.dart';
import 'package:lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';

mixin PatientFormController on State<PatientPage> {
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final phoneEC = TextEditingController();
  final documentEC = TextEditingController();
  final cepEC = TextEditingController();
  final streetAddressEC = TextEditingController();
  final numberEC = TextEditingController();
  final complementEC = TextEditingController();
  final stateEC = TextEditingController();
  final cityEC = TextEditingController();
  final districtEC = TextEditingController();
  final guardianEC = TextEditingController();
  final guardianIdentificationNumberEC = TextEditingController();

  void disposeForm() {
    nameEC.dispose();
    emailEC.dispose();
    phoneEC.dispose();
    documentEC.dispose();
    cepEC.dispose();
    streetAddressEC.dispose();
    numberEC.dispose();
    complementEC.dispose();
    stateEC.dispose();
    cityEC.dispose();
    districtEC.dispose();
    guardianEC.dispose();
    guardianIdentificationNumberEC.dispose();
  }

  void initializeForm(final PatientModel? patientModel) {
    if (patientModel != null) {
      nameEC.text = patientModel.name;
      emailEC.text = patientModel.email;
      phoneEC.text = patientModel.phoneNumber;
      documentEC.text = patientModel.document;
      cepEC.text = patientModel.address.cep;
      streetAddressEC.text = patientModel.address.streetAddress;
      numberEC.text = patientModel.address.number;
      complementEC.text = patientModel.address.streetComplement;
      stateEC.text = patientModel.address.state;
      cityEC.text = patientModel.address.city;
      districtEC.text = patientModel.address.district;
      guardianEC.text = patientModel.guardian;
      guardianIdentificationNumberEC.text =
          patientModel.guardianIdentificationNumber;
    }
  }

  PatientModel updatePatient(PatientModel patient) {
    return patient.copyWith(
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      address: patient.address.copyWith(
        cep: cepEC.text,
        streetAddress: streetAddressEC.text,
        number: numberEC.text,
        streetComplement: complementEC.text,
        state: stateEC.text,
        city: cityEC.text,
        district: districtEC.text,
      ),
      guardian: guardianEC.text,
      guardianIdentificationNumber: guardianIdentificationNumberEC.text,
    );
  }

  RegisterPatientModel createPatientRegister() {
    return (
      name: nameEC.text,
      email: emailEC.text,
      phoneNumber: phoneEC.text,
      document: documentEC.text,
      address: (
        cep: cepEC.text,
        streetAddress: streetAddressEC.text,
        number: numberEC.text,
        addressComplement: complementEC.text,
        state: stateEC.text,
        city: cityEC.text,
        district: districtEC.text
      ),
      guardian: guardianEC.text,
      guardianIdentificationNumber: guardianIdentificationNumberEC.text,
    );
  }
}
