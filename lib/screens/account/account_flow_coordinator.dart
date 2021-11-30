import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/screens/account/edit/edit_account_screen.dart';

import 'email/update_email_argument.dart';
import 'email/update_email_screen.dart';
import 'name/update_name_argument.dart';
import 'name/update_name_screen.dart';

abstract class AccountFlowCoordinator {
  /// Navigates to [EditAccountScreen]
  void goToEditAccountScreen();

  /// Navigates to [UpdateNameScreen]
  ///
  /// [argument] The screen argument
  void goToUpdateNameScreen(UpdateNameArgument argument);

  /// Closes [UpdateNameScreen]
  void closeUpdateNameScreen();

  /// Closes dialog for selecting image file
  void closeSelectImageDialog();

  /// Navigates to UpdateEmailScreen
  ///
  /// [argument] [UpdateEmailArgument]
  void goToUpdateEmailScreen(UpdateEmailArgument argument);

  /// Closes [UpdateEmailScreen]
  void closeUpdateEmailScreen();
}

class MyAccountFlowCoordinator implements AccountFlowCoordinator {
  final BuildContext _context;

  MyAccountFlowCoordinator(this._context);

  @override
  void closeSelectImageDialog() {
    Navigator.pop(_context);
  }

  @override
  void closeUpdateEmailScreen() {
    Navigator.pop(_context);
  }

  @override
  void closeUpdateNameScreen() {
    Navigator.pop(_context);
  }

  @override
  void goToUpdateEmailScreen(UpdateEmailArgument argument) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => UpdateEmailScreen(argument)),
    );
  }

  @override
  void goToUpdateNameScreen(UpdateNameArgument argument) {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (context) => UpdateNameScreen(argument)),
    );
  }

  @override
  void goToEditAccountScreen() {
    Navigator.push(
      _context,
      MaterialPageRoute(builder: (_) => const EditAccountScreen()),
    );
  }
}
