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

  static m0(message) => "Phone number verification failed: ${message}";

  static m1(error) => "Failed to sign in: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "enterPhoneNumber" : MessageLookupByLibrary.simpleMessage("Enter your mobile number"),
    "invalidPhoneNumber" : MessageLookupByLibrary.simpleMessage("The phone number you entered is invalid."),
    "next" : MessageLookupByLibrary.simpleMessage("Next"),
    "phoneNumberHint" : MessageLookupByLibrary.simpleMessage("Mobile number"),
    "phoneNumberRequired" : MessageLookupByLibrary.simpleMessage("Phone number is required."),
    "phoneNumberVerificationFailed" : m0,
    "phoneSignIn" : MessageLookupByLibrary.simpleMessage("Phone Sign In"),
    "signInError" : m1,
    "signInSuccessfulWithNullUser" : MessageLookupByLibrary.simpleMessage("Phone number verified and user signed in but user is null"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter\nAuth"),
    "youMayReceiveSMS" : MessageLookupByLibrary.simpleMessage("If you continue, you may receive an SMS for verification.")
  };
}
