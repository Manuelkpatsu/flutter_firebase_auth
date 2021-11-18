// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null, 'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;
 
      return instance;
    });
  } 

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null, 'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter\nAuth`
  String get title {
    return Intl.message(
      'Flutter\nAuth',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Phone Sign In`
  String get phoneSignIn {
    return Intl.message(
      'Phone Sign In',
      name: 'phoneSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter your mobile number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number`
  String get phoneNumberHint {
    return Intl.message(
      'Mobile number',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `If you continue, you may receive an SMS for verification.`
  String get youMayReceiveSMS {
    return Intl.message(
      'If you continue, you may receive an SMS for verification.',
      name: 'youMayReceiveSMS',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Phone number verified and user signed in but user is null`
  String get signInSuccessfulWithNullUser {
    return Intl.message(
      'Phone number verified and user signed in but user is null',
      name: 'signInSuccessfulWithNullUser',
      desc: '',
      args: [],
    );
  }

  /// `Failed to sign in: {error}`
  String signInError(Object error) {
    return Intl.message(
      'Failed to sign in: $error',
      name: 'signInError',
      desc: '',
      args: [error],
    );
  }

  /// `Phone number is required.`
  String get phoneNumberRequired {
    return Intl.message(
      'Phone number is required.',
      name: 'phoneNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `The phone number you entered is invalid.`
  String get invalidPhoneNumber {
    return Intl.message(
      'The phone number you entered is invalid.',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number verification failed: {message}`
  String phoneNumberVerificationFailed(Object message) {
    return Intl.message(
      'Phone number verification failed: $message',
      name: 'phoneNumberVerificationFailed',
      desc: '',
      args: [message],
    );
  }

  /// `Enter the 6-digit code sent to you at {phoneNumber}`
  String enterOTP(Object phoneNumber) {
    return Intl.message(
      'Enter the 6-digit code sent to you at $phoneNumber',
      name: 'enterOTP',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Enter the OTP code`
  String get otpHint {
    return Intl.message(
      'Enter the OTP code',
      name: 'otpHint',
      desc: '',
      args: [],
    );
  }

  /// `Verify your phone number`
  String get verifyTitle {
    return Intl.message(
      'Verify your phone number',
      name: 'verifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `The SMS code provided is incorrect.`
  String get incorrectSMSCode {
    return Intl.message(
      'The SMS code provided is incorrect.',
      name: 'incorrectSMSCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend code by SMS`
  String get resendCode {
    return Intl.message(
      'Resend code by SMS',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in 0:{countDownTimeInSeconds}`
  String resendCodeIn(Object countDownTimeInSeconds) {
    return Intl.message(
      'Resend code in 0:$countDownTimeInSeconds',
      name: 'resendCodeIn',
      desc: '',
      args: [countDownTimeInSeconds],
    );
  }

  /// `Select a country`
  String get selectCountry {
    return Intl.message(
      'Select a country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Search for a country`
  String get searchForCountry {
    return Intl.message(
      'Search for a country',
      name: 'searchForCountry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}