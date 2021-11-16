import 'dart:async';

import 'package:flutterfirebaseauth/screens/login/phone/phone_flow_coordinator.dart';
import 'package:logger/logger.dart';

import 'welcome_event.dart';

class WelcomeBloc {
  final _logger = Logger();
  final StreamController<WelcomeEvent> _eventController;
  final PhoneFlowCoordinator _phoneFlowCoordinator;

  WelcomeBloc(
    this._eventController,
    this._phoneFlowCoordinator,
  ) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [WelcomeEvent]
  _handleEvent(WelcomeEvent event) {
    switch (event.runtimeType) {
      case GoToPhoneSignInScreenEvent:
        _phoneFlowCoordinator.goToEnterNumberScreen();
        break;
    }
  }

  void dispose() {
    _eventController.close();
  }
}
