import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tuple/tuple.dart';

import 'repository/country_repository.dart';
import 'repository/user_repository.dart';
import 'screens/account/account_flow_coordinator.dart';
import 'screens/account/email/update_email_bloc.dart';
import 'screens/account/email/update_email_event.dart';
import 'screens/account/name/update_name_bloc.dart';
import 'screens/account/name/update_name_event.dart';
import 'screens/account/edit/edit_account_bloc.dart';
import 'screens/account/edit/edit_account_event.dart';
import 'screens/app/app_entry_bloc.dart';
import 'screens/login/phone/country/select_country_bloc.dart';
import 'screens/login/phone/country/select_country_domain_model.dart';
import 'screens/login/phone/country/select_country_event.dart';
import 'screens/login/phone/country/select_country_tile_bloc.dart';
import 'screens/login/phone/country/select_country_tile_event.dart';
import 'screens/login/phone/number/enter_number_bloc.dart';
import 'screens/login/phone/number/enter_number_event.dart';
import 'screens/login/phone/otp/enter_otp_arguments.dart';
import 'screens/login/phone/otp/enter_otp_bloc.dart';
import 'screens/login/phone/otp/enter_otp_event.dart';
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
  get.registerFactoryParam<MyAccountFlowCoordinator, BuildContext, void>(
    (context, _) => MyAccountFlowCoordinator(context),
  );

  /// App Entry
  get.registerFactoryParam<AppEntryBloc, void, void>(
    (_, empty) => AppEntryBloc(
      get<UserRepository>(),
    ),
  );

  /// Home screen
  get.registerFactoryParam<WelcomeBloc, BuildContext, StreamController<WelcomeEvent>>(
    (context, eventController) => WelcomeBloc(
      eventController,
      MyPhoneFlowCoordinator(context),
    ),
  );

  /// EnterNumberScreen
  get.registerFactoryParam<EnterNumberBloc, BuildContext,
      StreamController<EnterNumberEvent>>(
    (context, eventController) => EnterNumberBloc(
      context,
      eventController,
      get<MyPhoneFlowCoordinator>(param1: context),
      get<UserRepository>(),
    ),
  );

  /// SelectCountryScreen
  get.registerFactory(() => SelectCountryDomainModel(get<CountryRepository>()));
  get.registerFactoryParam<SelectCountryBloc, BuildContext,
      StreamController<SelectCountryEvent>>(
    (context, eventController) => SelectCountryBloc(
      eventController,
      get<SelectCountryDomainModel>(),
    ),
  );
  get.registerFactoryParam<SelectCountryTileBloc, BuildContext,
      StreamController<SelectCountryTileEvent>>(
    (context, eventController) => SelectCountryTileBloc(
      eventController,
      get<MyPhoneFlowCoordinator>(param1: context),
    ),
  );

  /// EnterOTPScreen
  get.registerFactoryParam<EnterOTPBloc, BuildContext,
      Tuple2<StreamController<EnterOTPEvent>, EnterOTPArguments>>(
    (context, tuple) => EnterOTPBloc(
      context,
      tuple.item1,
      tuple.item2,
      get<MyPhoneFlowCoordinator>(param1: context),
      get<UserRepository>(),
    ),
  );

  /// UpdateEmailScreen
  get.registerFactoryParam<UpdateEmailBloc, BuildContext,
      StreamController<UpdateEmailEvent>>(
    (context, eventController) => UpdateEmailBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<MyAccountFlowCoordinator>(param1: context),
    ),
  );

  /// EditAccountScreen
  get.registerFactoryParam<EditAccountBloc, BuildContext,
      StreamController<EditAccountEvent>>(
        (context, eventController) => EditAccountBloc(
      get<UserRepository>(),
      get<MyAccountFlowCoordinator>(param1: context),
    ),
  );

  /// UpdateNameScreen
  get.registerFactoryParam<UpdateNameBloc, BuildContext,
      StreamController<UpdateNameEvent>>(
    (context, eventController) => UpdateNameBloc(
      context,
      eventController,
      get<UserRepository>(),
      get<MyAccountFlowCoordinator>(param1: context),
    ),
  );
}
