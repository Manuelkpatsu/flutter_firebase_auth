import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EditAccountModelData extends Equatable {
  final String? photoURL;
  final String? displayName;
  final String? phoneNumber;
  final String? email;
  final bool emailVerified;
  final double? uploadProgress;
  final bool loggingOut;

  const EditAccountModelData({
    this.photoURL,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.emailVerified = false,
    this.uploadProgress,
    this.loggingOut = false,
  });

  EditAccountModelData copyWith({
    String? photoURL,
    String? displayName,
    String? phoneNumber,
    String? email,
    bool? emailVerified,
    double? uploadProgress,
    bool? loggingOut
  }) {
    return EditAccountModelData(
      photoURL: photoURL ?? this.photoURL,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      uploadProgress: uploadProgress,
      loggingOut: loggingOut ?? this.loggingOut,
    );
  }

  @override
  List<Object?> get props => [
    photoURL,
    displayName,
    phoneNumber,
    email,
    emailVerified,
    uploadProgress,
    loggingOut,
  ];
}
