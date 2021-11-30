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

  const EditAccountModelData({
    this.photoURL,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.emailVerified = false,
    this.uploadProgress,
  });

  EditAccountModelData copyWith({
    String? photoURL,
    String? displayName,
    String? phoneNumber,
    String? email,
    bool? emailVerified,
    double? uploadProgress,
  }) {
    return EditAccountModelData(
      photoURL: photoURL ?? this.photoURL,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      uploadProgress: uploadProgress,
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
  ];
}
