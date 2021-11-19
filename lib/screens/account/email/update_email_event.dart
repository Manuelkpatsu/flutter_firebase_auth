abstract class UpdateEmailEvent {}

class UpdateUserEmailEvent extends UpdateEmailEvent {
  final String email;

  UpdateUserEmailEvent(this.email);
}
