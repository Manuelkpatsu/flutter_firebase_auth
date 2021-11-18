import 'package:flutter/material.dart';

abstract class EnterOTPEvent {}

@immutable
class SignInWithSMSCodeEvent extends EnterOTPEvent {
  final String otp;

  SignInWithSMSCodeEvent(this.otp);
}

class ResendCodeEvent extends EnterOTPEvent {}
