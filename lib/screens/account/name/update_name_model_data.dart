import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UpdateNameModelData extends Equatable {
  final bool updatingName;

  const UpdateNameModelData({
    this.updatingName = false,
  });

  UpdateNameModelData copyWith({
    bool? updatingName,
  }) {
    return UpdateNameModelData(
      updatingName: updatingName ?? this.updatingName,
    );
  }

  @override
  List<Object?> get props => [updatingName];
}
