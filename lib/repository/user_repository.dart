import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRepository {
  static const profilePhotoPath = 'profilePhoto';

  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _firebaseStorage;

  UserRepository(this._firebaseAuth, this._firebaseStorage);

  /// Starts a phone number verification process for the given phone number.
  ///
  /// [phoneNumber] The phone number for the account the user is signing up
  ///   for or signing into.
  ///
  /// [timeout] The maximum amount of time you are willing to wait for SMS
  ///   auto-retrieval to be completed by the library.
  ///
  /// [forceResendingToken] The [forceResendingToken] obtained from [codeSent]
  ///   callback to force re-sending another verification SMS before the
  ///   auto-retrieval timeout.
  ///
  /// [verificationCompleted] Triggered when an SMS is auto-retrieved or the
  ///   phone number has been instantly verified.
  ///
  /// [verificationFailed] Triggered when an error occurred during phone number
  ///   verification.
  ///
  /// [codeSent] Triggered when an SMS has been sent to the users phone.
  ///
  /// [codeAutoRetrievalTimeout] Triggered when SMS auto-retrieval times out.
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Duration timeOut,
    PhoneVerificationCompleted verificationCompleted,
    PhoneVerificationFailed verificationFailed,
    PhoneCodeSent codeSent,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  ) {
    return _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  /// Signs user in with OTP
  ///
  /// [verificationId] verification ID
  /// [smsCode] OTP
  Future<UserCredential> signInWithSMSCode(String verificationId, String smsCode) {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return signInWithAuthCredential(credential);
  }

  /// Signs user in with [AuthCredential]
  ///
  /// [authCredential] auth credential
  Future<UserCredential> signInWithAuthCredential(
      AuthCredential authCredential) {
    return _firebaseAuth.signInWithCredential(authCredential);
  }

  /// Signs the active user out
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  /// Checks if the current user is signed in
  Future<bool> isSignedIn() {
    return Future.value(_firebaseAuth.currentUser != null);
  }

  /// Gets the current user
  Future<User?> getCurrentUser() {
    return Future.value(_firebaseAuth.currentUser);
  }

  /// Notifies about changes to any user updates.
  Stream<User?> userChanges() {
    return _firebaseAuth.userChanges();
  }

  /// Updates the current user name
  ///
  /// [newName] new name to update to
  Future<void> updateUsername(String newName) {
    return getCurrentUser()
        .then((user) => user!.updateDisplayName(newName));
  }

  /// Updates the active user's profile photo
  ///
  /// [photoURL] photo URL
  Future<void> updateProfilePhoto(String photoURL) {
    return getCurrentUser()
        .then((user) => user!.updatePhotoURL(photoURL));
  }

  /// Returns an upload task
  ///
  /// [image] image file to upload
  Future<UploadTask> getUploadImageTask(File image) {
    return getCurrentUser().then((user) => _firebaseStorage
        .ref(profilePhotoPath)
        .child(user!.uid)
        .putFile(image));
  }
}
