import 'package:flutter/foundation.dart';
import 'package:functional_listener/functional_listener.dart';
import 'package:tuple/tuple.dart';

import 'enter_otp_bloc.dart';

extension EnterOTPListenable on EnterOTPBloc {
  /// Exposes a [bool].
  ///
  /// True if the progress indicator should be shown, false otherwise.
  ValueListenable<bool> get progressIndicator =>
      map((m) => m.verifyingPhoneNumber || m.signingIn);

  /// Exposes a [bool].
  ///
  /// True if the form should be enabled, false otherwise.
  ValueListenable<bool> get smsCodeTextFormField => map((m) => m.signingIn);

  /// Exposes a [Tuple2]<[bool], [bool]>.
  ///
  /// [Tuple2.item1] - true if the button should be shown, false otherwise.
  ///
  /// [Tuple2.item2] - true if the button should be enabled, false otherwise.
  ValueListenable<Tuple2<bool, bool>> get resendCodeButton =>
      map((m) => Tuple2(m.countDownTimeInSecs < 1, !m.signingIn));

  /// Exposes a [Tuple2]<[bool], [int]>.
  ///
  /// [Tuple2.item1] - true if the text should be shown, false otherwise.
  ///
  /// [Tuple2.item2] - the countdown time in seconds.
  ValueListenable<Tuple2<bool, int>> get resendCodeInText =>
      map((m) => Tuple2(m.countDownTimeInSecs > 0, m.countDownTimeInSecs));

  /// Exposes a [bool].
  ///
  /// True if the button should be enabled, false otherwise.
  ValueListenable<bool> get nextButton =>
      map((m) => !m.verifyingPhoneNumber && !m.signingIn);
}
