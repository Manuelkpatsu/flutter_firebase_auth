import 'package:flutter/material.dart';

import 'select_country_tile_model_data.dart';

abstract class SelectCountryTileEvent {}

@immutable
class ChooseCountryEvent extends SelectCountryTileEvent {
  final SelectCountryTileModelData modelData;

  ChooseCountryEvent(this.modelData);
}
