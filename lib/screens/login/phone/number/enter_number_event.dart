import 'package:flutter/material.dart';

abstract class EnterNumberEvent {}

@immutable
class VerifyPhoneNumberEvent extends EnterNumberEvent {
  final String phoneNumber;

  VerifyPhoneNumberEvent(this.phoneNumber);
}

class GoToSelectCountryScreenEvent extends EnterNumberEvent {}
