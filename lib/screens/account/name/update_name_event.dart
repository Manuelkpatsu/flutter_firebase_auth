abstract class UpdateNameEvent {}

class UpdateUserNameEvent extends UpdateNameEvent {
  final String fullName;

  UpdateUserNameEvent(this.fullName);
}
