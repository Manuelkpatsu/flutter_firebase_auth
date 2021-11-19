import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UpdateEmailModelData extends Equatable {
  final bool updatingEmail;

  const UpdateEmailModelData({
    this.updatingEmail = false,
  });

  UpdateEmailModelData copyWith({String? message, bool? updatingEmail}) {
    return UpdateEmailModelData(
      updatingEmail: updatingEmail ?? this.updatingEmail,
    );
  }

  @override
  List<Object?> get props => [updatingEmail];
}
