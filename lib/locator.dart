import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'repository/country_repository.dart';
import 'repository/user_repository.dart';
import 'screens/login/phone/phone_flow_coordinator.dart';
import 'screens/welcome/welcome_bloc.dart';
import 'screens/welcome/welcome_event.dart';

final GetIt get = GetIt.instance;

void setUpLocator() {
  get.registerFactory(
    () => UserRepository(FirebaseAuth.instance, FirebaseStorage.instance),
  );
  get.registerFactory(() => CountryRepository());
  get.registerFactoryParam<MyPhoneFlowCoordinator, BuildContext, void>(
    (context, _) => MyPhoneFlowCoordinator(context),
  );

  /// Home screen
  get.registerFactoryParam<WelcomeBloc, BuildContext, StreamController<WelcomeEvent>>(
    (context, eventController) => WelcomeBloc(
      eventController,
      MyPhoneFlowCoordinator(context),
    ),
  );
}
