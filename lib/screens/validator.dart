// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

class Validator {
  static FormFieldValidator<String>? name = (name) {
    if (name == null || name.isEmpty) {
      return S.current.nameCannotBeEmpty;
    }
    return null;
  };

  static FormFieldValidator<String>? email = (email) {
    if (email == null || email.isEmpty) {
      return S.current.emailCannotBeEmpty;
    }

    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return S.current.invalidEmail;
    }

    return null;
  };
}
