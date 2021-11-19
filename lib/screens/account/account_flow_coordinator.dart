import 'package:flutter/material.dart';

abstract class AccountFlowCoordinator {}

class MyAccountFlowCoordinator implements AccountFlowCoordinator {
  final BuildContext _context;

  MyAccountFlowCoordinator(this._context);
}
