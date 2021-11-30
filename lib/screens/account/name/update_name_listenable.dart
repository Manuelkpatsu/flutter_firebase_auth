import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';

import 'update_name_bloc.dart';

extension UpdateNameListenable on UpdateNameBloc {
  /// Exposes a [bool]
  ///
  /// True if progressIndicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator => map((m) => m.updatingName);

  /// Exposes a [bool].
  ///
  /// True if nextButton should be enabled, false otherwise.
  ValueListenable<bool> get nextButton => map((m) => !m.updatingName);
}
