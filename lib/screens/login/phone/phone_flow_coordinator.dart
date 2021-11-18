import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/screens/account/profile/profile_screen.dart';

import 'number/enter_number_screen.dart';

abstract class PhoneFlowCoordinator {
  /// Navigates to EnterNumberScreen
  void goToEnterNumberScreen();

  /// Navigates to [ProfileScreen]
  void goToProfileScreen();
}

class MyPhoneFlowCoordinator implements PhoneFlowCoordinator {
  final BuildContext _context;

  MyPhoneFlowCoordinator(this._context);

  @override
  void goToEnterNumberScreen() {
    Navigator.pushNamed(
      _context,
      EnterNumberScreen.routeName,
    );
  }

  @override
  void goToProfileScreen() {
    Navigator.pushNamed(
      _context,
      ProfileScreen.routeName,
    );
  }
}
