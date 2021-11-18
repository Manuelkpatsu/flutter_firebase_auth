import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class PhoneModelData extends Equatable {
  final bool verifyingPhoneNumber;

  const PhoneModelData({this.verifyingPhoneNumber = false});

  PhoneModelData copyWith({bool? verifyingPhoneNumber}) {
    return PhoneModelData(
      verifyingPhoneNumber: verifyingPhoneNumber ?? this.verifyingPhoneNumber,
    );
  }

  @override
  List<Object?> get props => [verifyingPhoneNumber];
}
