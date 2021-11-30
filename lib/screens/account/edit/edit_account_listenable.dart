import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'edit_account_bloc.dart';

extension EditAccountListenable on EditAccountBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.loggingOut);

  /// The profile photo to display.
  ValueListenable<String?> get accountImage => map((m) => m.photoURL);

  /// The full name to display.
  ValueListenable<String?> get fullNameTextField => map((m) => m.displayName);

  /// The phone number to display.
  ValueListenable<String?> get phoneNumberTextField => map((m) => m.phoneNumber);

  /// The email address to display.
  ValueListenable<String?> get emailAddressTextField => map((m) => m.email);

  /// True if the user's email is verified, false otherwise.
  ValueListenable<bool> get isEmailVerified => map((m) => m.emailVerified);

  /// Progress of the image upload.
  ValueListenable<double?> get imageUploadProgressIndicator =>
      map((m) => m.uploadProgress);

  /// Exposes a [bool].
  ///
  /// True if the button should be enabled, false otherwise.
  ValueListenable<bool> get logoutButton => map((m) => !m.loggingOut);
}
