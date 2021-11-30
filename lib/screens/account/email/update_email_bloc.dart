// ignore_for_file: avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';
import 'package:logger/logger.dart';

import '../../util.dart';
import '../account_flow_coordinator.dart';
import 'update_email_event.dart';
import 'update_email_model_data.dart';

class UpdateEmailBloc extends ValueNotifier<UpdateEmailModelData> {
  final _logger = Logger();
  final BuildContext _context;
  final StreamController<UpdateEmailEvent> _eventController;
  final UserRepository _userRepository;
  final AccountFlowCoordinator _accountFlowCoordinator;

  UpdateEmailBloc(
      this._context,
      this._eventController,
      this._userRepository,
      this._accountFlowCoordinator,
      ) : super(const UpdateEmailModelData()) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));
  }

  /// Handles [UpdateEmailEvent]
  void _handleEvent(UpdateEmailEvent event) {
    switch (event.runtimeType) {
      case UpdateUserEmailEvent:
        final updateEmailEvent = event as UpdateUserEmailEvent;
        _updateEmail(updateEmailEvent.email);
        break;
    }
  }

  /// Updates the current user's email.
  ///
  /// [email] new email to update to.
  void _updateEmail(String email) {
    value = value.copyWith(updatingEmail: true);

    _userRepository.getCurrentUser().then((user) {
      if (user == null) {
        value = value.copyWith(updatingEmail: false);
        print('User is not signed in');
        return;
      }

      _verifyBeforeUpdateEmail(user, email);
    }).onError((error, stackTrace) {
      value = value.copyWith(updatingEmail: false);
      print('Error getting the current user');
    });
  }

  /// Sends a verification email to the new email address. The user's email will
  /// be updated to the new one after being verified.
  ///
  /// [user] the user to update the email for.
  ///
  /// [email] the new email address.
  void _verifyBeforeUpdateEmail(User user, String email) {
    user.verifyBeforeUpdateEmail(email).then((_) {
      Util.showSnackbar(_context, S.current.verificationEmailSent);
      onVerificationEmailSent();
    }).onError((FirebaseAuthException error, stackTrace) {
      Util.showSnackbar(_context, error.message ?? error.toString());
    }).whenComplete(() {
      value = value.copyWith(updatingEmail: false);
    });
  }

  void onVerificationEmailSent() {
    _accountFlowCoordinator.closeUpdateEmailScreen();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
