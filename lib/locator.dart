import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'screens/login/phone/phone_flow_coordinator.dart';
import 'screens/welcome/welcome_bloc.dart';
import 'screens/welcome/welcome_event.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  /// Home screen
  get.registerFactoryParam<WelcomeBloc, BuildContext, StreamController<WelcomeEvent>>(
    (context, eventController) => WelcomeBloc(
      eventController,
      MyPhoneFlowCoordinator(context),
    ),
  );
}
