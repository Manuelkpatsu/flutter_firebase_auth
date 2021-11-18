import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'enter_number_bloc.dart';

extension EnterNumberListenable on EnterNumberBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.verifyingPhoneNumber);

  /// Exposes a [String].
  ///
  /// The country code for displaying the country's image.
  ValueListenable<String> get countryFlagImage => map((m) => m.countryCode);

  /// Exposes a [String].
  ///
  /// The country's dial code to display.
  ValueListenable<String> get countryDialCode => map((m) => m.countryDialCode);

  /// Exposes a [bool].
  ///
  /// True if the button should be enabled, false otherwise.
  ValueListenable<bool> get nextButton => map((m) => !m.verifyingPhoneNumber);
}
