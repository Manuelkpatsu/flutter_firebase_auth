import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'update_email_bloc.dart';

extension UpdateEmailListenable on UpdateEmailBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.updatingEmail);

  /// Exposes a [bool].
  ///
  /// True if the button should be enabled, false otherwise.
  ValueListenable<bool> get nextButton => map((m) => !m.updatingEmail);
}
