import 'package:json_annotation/json_annotation.dart';

part 'patient_address_model.g.dart';

@JsonSerializable()
class PatientAddressModel {
  final String cep;

  @JsonKey(name: "street_address")
  final String streetAddress;
  final String number;

  @JsonKey(name: "street_complement", defaultValue: null)
  final String streetComplement;
  final String state;
  final String city;
  final String district;

  factory PatientAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PatientAddressModelFromJson(json);

  PatientAddressModel({
    required this.cep,
    required this.streetAddress,
    required this.number,
    required this.streetComplement,
    required this.state,
    required this.city,
    required this.district,
  });

  Map<String, dynamic> toJson() => _$PatientAddressModelToJson(this);

  PatientAddressModel copyWith({
    String? cep,
    String? streetAddress,
    String? number,
    String? streetComplement,
    String? state,
    String? city,
    String? district,
  }) {
    return PatientAddressModel(
      cep: cep ?? this.cep,
      streetAddress: streetAddress ?? this.streetAddress,
      number: number ?? this.number,
      streetComplement: streetComplement ?? this.streetComplement,
      state: state ?? this.state,
      city: city ?? this.city,
      district: district ?? this.district,
    );
  }
}
