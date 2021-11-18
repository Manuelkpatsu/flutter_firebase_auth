// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';

import '../phone_model_data.dart';

@immutable
class EnterOTPModelData extends PhoneModelData {
  final int countDownTimeInSecs;
  final bool signingIn;

  const EnterOTPModelData({
    bool verifyingPhoneNumber = false,
    this.countDownTimeInSecs = 15,
    this.signingIn = false,
  }) : super(verifyingPhoneNumber: verifyingPhoneNumber);

  EnterOTPModelData copyWith(
      {bool? verifyingPhoneNumber,
        int? countDownTimeInSecs,
        bool? signingIn}) {
    return EnterOTPModelData(
        verifyingPhoneNumber: verifyingPhoneNumber ?? this.verifyingPhoneNumber,
        countDownTimeInSecs: countDownTimeInSecs ?? this.countDownTimeInSecs,
        signingIn: signingIn ?? this.signingIn);
  }

  @override
  List<Object?> get props {
    return super.props..addAll([countDownTimeInSecs, signingIn]);
  }
}
