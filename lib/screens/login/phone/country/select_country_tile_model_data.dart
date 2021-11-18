import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class SelectCountryTileModelData extends Equatable {
  final String code;
  final String name;
  final String dialCode;

  const SelectCountryTileModelData({
    required this.code,
    required this.name,
    required this.dialCode,
  });

  @override
  List<Object?> get props => [code, name, dialCode];
}
