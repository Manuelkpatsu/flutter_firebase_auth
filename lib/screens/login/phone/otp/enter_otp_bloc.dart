import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';
import 'package:logger/logger.dart';

import '../../../util.dart';
import '../phone_bloc.dart';
import '../phone_flow_coordinator.dart';
import 'enter_otp_event.dart';
import 'enter_otp_model_data.dart';
import 'enter_otp_arguments.dart';

class EnterOTPBloc extends PhoneBloc<EnterOTPModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<EnterOTPEvent> _eventController;
  final PhoneFlowCoordinator _phoneFlowCoordinator;
  final EnterOTPArguments _arguments;
  final UserRepository _userRepository;
  late final StreamSubscription _countDownSubscription;

  EnterOTPBloc(
    this._context,
    this._eventController,
    this._arguments,
    this._phoneFlowCoordinator,
    this._userRepository,
  ) : super(
          const EnterOTPModelData(),
          _context,
          _phoneFlowCoordinator,
          _userRepository,
        ) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));

    _startCountDownTimer();
  }

  /// Handles [EnterOTPEvent]
  _handleEvent(EnterOTPEvent event) {
    switch (event.runtimeType) {
      case ResendCodeEvent:
        verifyPhoneNumber(_arguments.phoneNumber);
        break;
      case SignInWithSMSCodeEvent:
        final signInWithSMSCodeEvent = event as SignInWithSMSCodeEvent;
        _signInWithSMSCode(signInWithSMSCodeEvent.otp);
        break;
    }
  }

  void _startCountDownTimer() {
    _countDownSubscription =
        Stream.periodic(const Duration(seconds: 1), (v) => v).take(15).listen((count) {
      int newTime = value.countDownTimeInSecs - 1;
      value = value.copyWith(countDownTimeInSecs: newTime);
    });
  }

  void _signInWithSMSCode(String smsCode) {
    value = value.copyWith(signingIn: true);

    _userRepository
        .signInWithSMSCode(_arguments.verificationId, smsCode)
        .then((userCredential) => _phoneFlowCoordinator.goToProfileScreen())
        .whenComplete(() => value = value.copyWith(signingIn: false))
        .catchError((error) {
      FirebaseAuthException exception = error;
      String errorMessage;
      switch (exception.code) {
        case 'invalid-verification-code':
          errorMessage = S.current.incorrectSMSCode;
          break;
        default:
          errorMessage = S.current.signInError(exception.toString());
          break;
      }

      Util.showSnackbar(_context, errorMessage);
    });
  }

  @override
  void onPhoneCodeSent(String verificationID, String phoneNumber) {
    value = const EnterOTPModelData();
    _startCountDownTimer();
  }

  @override
  dispose() {
    _countDownSubscription.cancel();
    super.dispose();
  }
}
