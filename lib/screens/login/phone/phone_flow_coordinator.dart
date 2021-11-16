import 'package:flutter/material.dart';

import 'number/enter_number_screen.dart';

abstract class PhoneFlowCoordinator {
  /// Navigates to EnterNumberScreen
  void goToEnterNumberScreen();
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
}
