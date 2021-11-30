import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

abstract class EditAccountEvent {}

///
/// Events handled by the bloc
///
abstract class EditAccountBlocEvent extends EditAccountEvent {}

@immutable
class SelectImageEvent extends EditAccountBlocEvent {
  final ImageSource source;

  SelectImageEvent(this.source);
}

@immutable
class GoToUpdateNameEvent extends EditAccountBlocEvent {
  final String name;

  GoToUpdateNameEvent(this.name);
}

@immutable
class GoToUpdateEmailEvent extends EditAccountBlocEvent {
  final String? email;

  GoToUpdateEmailEvent(this.email);
}

///
/// Events handled by the state
///
abstract class EditAccountStateEvent extends EditAccountEvent {}

class ShowSelectImageOptionsSheetEvent extends EditAccountStateEvent {}

@immutable
class ShowSnackBarEvent extends EditAccountStateEvent {
  final String message;

  ShowSnackBarEvent(this.message);
}
