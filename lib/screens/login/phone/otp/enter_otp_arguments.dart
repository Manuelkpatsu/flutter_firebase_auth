import 'package:flutter/material.dart';

@immutable
class EnterOTPArguments {
  final String verificationId;
  final String phoneNumber;

  const EnterOTPArguments(this.verificationId, this.phoneNumber);
}
