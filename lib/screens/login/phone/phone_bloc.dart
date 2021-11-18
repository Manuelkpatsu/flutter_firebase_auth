// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';

import '../../util.dart';
import 'phone_flow_coordinator.dart';
import 'phone_model_data.dart';

abstract class PhoneBloc<M extends PhoneModelData> extends ValueNotifier<M> {
  final BuildContext _context;
  final PhoneFlowCoordinator _phoneFlowCoordinator;
  final UserRepository _userRepository;

  PhoneBloc(
    M modelData,
    this._context,
    this._phoneFlowCoordinator,
    this._userRepository,
  ) : super(modelData);

  @protected
  void verifyPhoneNumber(String phoneNumber) {
    PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      _userRepository.signInWithAuthCredential(authCredential).then((userCredential) {
        _phoneFlowCoordinator.goToProfileScreen();
      }).whenComplete(() {
        value = value.copyWith(verifyingPhoneNumber: false) as M;
      }).catchError((error) {
        Util.showSnackbar(_context, error.toString());
      });
    };

    final phoneVerificationFailed = (FirebaseAuthException authException) {
      value = value.copyWith(verifyingPhoneNumber: false) as M;

      String error;
      switch (authException.code) {
        case 'invalid-phone-number':
          error = S.current.invalidPhoneNumber;
          break;
        default:
          error = S.current.phoneNumberVerificationFailed(
            authException.message!,
          );
          break;
      }

      Util.showSnackbar(_context, error);
    };

    final phoneCodeSent = (String verificationID, [int? forceResent]) {
      value = value.copyWith(verifyingPhoneNumber: false) as M;
      onPhoneCodeSent(verificationID, phoneNumber);
    };

    final phoneCodeAutoRetrievalTimeout = (String verificationID) {
      // TODO: implement onPhoneCodeAutoRetrievalTimeout
    };

    value = value.copyWith(verifyingPhoneNumber: true) as M;
    _userRepository
        .verifyPhoneNumber(
            phoneNumber,
            const Duration(seconds: 30),
            phoneVerificationCompleted,
            phoneVerificationFailed,
            phoneCodeSent,
            phoneCodeAutoRetrievalTimeout)
        .catchError((error, stackTrace) {
      Util.showSnackbar(_context, error.toString());
    });
  }

  void onPhoneCodeSent(String verificationID, String phoneNumber);
}
