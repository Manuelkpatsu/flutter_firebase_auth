import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/screens/account/profile/profile_screen.dart';

import 'country/select_country_screen.dart';
import 'number/enter_number_screen.dart';
import 'otp/enter_otp_arguments.dart';
import 'otp/enter_otp_screen.dart';

abstract class PhoneFlowCoordinator {
  /// Navigates to EnterNumberScreen
  void goToEnterNumberScreen();

  /// Navigates to [ProfileScreen]
  void goToProfileScreen();

  /// Navigates to EnterOTPScreen
  ///
  /// [verificationId] verification ID
  /// [phoneNumber] phone number to verify
  void goToEnterOTPScreen(String verificationId, String phoneNumber);

  void goToSelectCountryScreen();
}

class MyPhoneFlowCoordinator implements PhoneFlowCoordinator {
  final BuildContext _context;

  MyPhoneFlowCoordinator(this._context);

  @override
  void goToEnterNumberScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => const EnterNumberScreen()),
    );
  }

  @override
  void goToProfileScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  @override
  void goToSelectCountryScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => const SelectCountryScreen()),
    );
  }

  @override
  void goToEnterOTPScreen(String verificationId, String phoneNumber) {
    final enterOTPArguments = EnterOTPArguments(verificationId, phoneNumber);

    Navigator.push(
      _context,
      MaterialPageRoute(
        builder: (_) => EnterOTPScreen(enterOTPArguments),
      ),
    );
  }
}
