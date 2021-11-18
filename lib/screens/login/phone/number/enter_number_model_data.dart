import 'package:flutter/material.dart';

import '../phone_model_data.dart';

@immutable
class EnterNumberModelData extends PhoneModelData {
  final String countryCode;
  final String countryDialCode;

  const EnterNumberModelData({
    bool verifyingPhoneNumber = false,
    this.countryCode = 'GH',
    this.countryDialCode = '+233',
  }) : super(verifyingPhoneNumber: verifyingPhoneNumber);

  EnterNumberModelData copyWith({
    bool? verifyingPhoneNumber,
    String? countryCode,
    String? countryDialCode,
  }) {
    return EnterNumberModelData(
      verifyingPhoneNumber: verifyingPhoneNumber ?? this.verifyingPhoneNumber,
      countryCode: countryCode ?? this.countryCode,
      countryDialCode: countryDialCode ?? this.countryDialCode,
    );
  }

  @override
  List<Object?> get props {
    return super.props..addAll([countryCode, countryDialCode]);
  }
}