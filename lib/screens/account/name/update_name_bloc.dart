import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/repository/user_repository.dart';
import 'package:logger/logger.dart';

import '../../util.dart';
import '../account_flow_coordinator.dart';
import 'update_name_event.dart';
import 'update_name_model_data.dart';

class UpdateNameBloc extends ValueNotifier<UpdateNameModelData> {
  final BuildContext _context;
  final StreamController<UpdateNameEvent> _eventController;
  final UserRepository _userRepository;
  final AccountFlowCoordinator _accountFlowCoordinator;
  final Logger _logger = Logger();

  UpdateNameBloc(
    this._context,
    this._eventController,
    this._userRepository,
    this._accountFlowCoordinator,
  ) : super(const UpdateNameModelData()) {
    _eventController.stream.listen((event) => _handleEvent(event)).onError((error) {
      _logger.e('Error responding to event', error);
    });
  }

  /// Handles [UpdateNameEvent]
  _handleEvent(UpdateNameEvent event) {
    switch (event.runtimeType) {
      case UpdateUserNameEvent:
        final updateNameEvent = event as UpdateUserNameEvent;
        _updateUserName(updateNameEvent.fullName);
        break;
    }
  }

  /// Updates the current user's full name.
  ///
  /// [newName] new name to update to.
  void _updateUserName(String newName) {
    value = value.copyWith(updatingName: true);

    _userRepository.updateUsername(newName).then((_) {
      Util.showSnackbar(_context, S.current.nameUpdated);
      _accountFlowCoordinator.closeUpdateNameScreen();
    }).catchError((error) {
      _logger.e('Error updating username', error);
      Util.showSnackbar(_context, S.current.nameUpdateFailed);
    }).whenComplete(() {
      value = value.copyWith(updatingName: false);
    });
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}
