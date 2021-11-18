import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';
import 'package:flutterfirebaseauth/screens/login/phone/number/enter_number_model_data.dart';
import 'package:flutterfirebaseauth/screens/login/phone/phone_bloc.dart';
import 'package:flutterfirebaseauth/screens/login/phone/phone_flow_coordinator.dart';
import 'package:logger/logger.dart';

import 'enter_number_event.dart';

class EnterNumberBloc extends PhoneBloc<EnterNumberModelData> {
  final _logger = Logger();
  final StreamController<EnterNumberEvent> _eventController;
  final PhoneFlowCoordinator _phoneFlowCoordinator;

  EnterNumberBloc(
      BuildContext context,
      this._eventController,
      this._phoneFlowCoordinator,
      UserRepository userRepository,
      ) : super(
    const EnterNumberModelData(),
    context,
    _phoneFlowCoordinator,
    userRepository,
  ) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [EnterNumberEvent]
  _handleEvent(EnterNumberEvent event) {
    switch (event.runtimeType) {
      case VerifyPhoneNumberEvent:
        final phoneNumber = (event as VerifyPhoneNumberEvent).phoneNumber;
        verifyPhoneNumber('${value.countryDialCode}$phoneNumber');
        break;
      case GoToSelectCountryScreenEvent:
        _goToSelectCountryScreen();
        break;
    }
  }

  void _goToSelectCountryScreen() {
    _phoneFlowCoordinator.goToSelectCountryScreen();
  }

  @override
  void onPhoneCodeSent(String verificationID, String phoneNumber) {
    value = const EnterNumberModelData();
    _phoneFlowCoordinator.goToEnterOTPScreen(verificationID, phoneNumber);
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }

}
