// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(phoneNumber) => "Enter the 6-digit code sent to you at ${phoneNumber}";

  static m1(message) => "Phone number verification failed: ${message}";

  static m2(countDownTimeInSeconds) => "Resend code in 0:${countDownTimeInSeconds}";

  static m3(error) => "Failed to sign in: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "emailAddress" : MessageLookupByLibrary.simpleMessage("Email address"),
    "emailCannotBeEmpty" : MessageLookupByLibrary.simpleMessage("Email cannot be empty."),
    "enterOTP" : m0,
    "enterPhoneNumber" : MessageLookupByLibrary.simpleMessage("Enter your mobile number"),
    "incorrectSMSCode" : MessageLookupByLibrary.simpleMessage("The SMS code provided is incorrect."),
    "invalidEmail" : MessageLookupByLibrary.simpleMessage("The email you entered is invalid."),
    "invalidPhoneNumber" : MessageLookupByLibrary.simpleMessage("The phone number you entered is invalid."),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "otpHint" : MessageLookupByLibrary.simpleMessage("Enter the OTP code"),
    "phoneNumberHint" : MessageLookupByLibrary.simpleMessage("Mobile number"),
    "phoneNumberRequired" : MessageLookupByLibrary.simpleMessage("Phone number is required."),
    "phoneNumberVerificationFailed" : m1,
    "phoneSignIn" : MessageLookupByLibrary.simpleMessage("Phone Sign In"),
    "receiptsWillBeSent" : MessageLookupByLibrary.simpleMessage("Receipts will be sent to your email address"),
    "resendCode" : MessageLookupByLibrary.simpleMessage("Resend code by SMS"),
    "resendCodeIn" : m2,
    "searchForCountry" : MessageLookupByLibrary.simpleMessage("Search for a country"),
    "selectCountry" : MessageLookupByLibrary.simpleMessage("Select a country"),
    "signInError" : m3,
    "signInSuccessfulWithNullUser" : MessageLookupByLibrary.simpleMessage("Phone number verified and user signed in but user is null"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter\nAuth"),
    "verificationEmailSent" : MessageLookupByLibrary.simpleMessage("A verification email has been sent to your new email."),
    "verifyTitle" : MessageLookupByLibrary.simpleMessage("Verify your phone number"),
    "whatsYourEmail" : MessageLookupByLibrary.simpleMessage("What\'s your email address?"),
    "youMayReceiveSMS" : MessageLookupByLibrary.simpleMessage("If you continue, you may receive an SMS for verification.")
  };
}
