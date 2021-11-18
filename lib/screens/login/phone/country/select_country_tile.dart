import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../locator.dart';
import 'select_country_tile_bloc.dart';
import 'select_country_tile_model_data.dart';
import 'select_country_tile_event.dart';

class SelectCountryTile extends StatelessWidget {
  late final SelectCountryTileBloc bloc;
  final eventController = StreamController<SelectCountryTileEvent>();
  final SelectCountryTileModelData modelData;

  SelectCountryTile(this.modelData, BuildContext context)
      : super(key: ValueKey(modelData.code)) {
    bloc = get<SelectCountryTileBloc>(param1: context, param2: eventController);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -2, vertical: -1),
      leading: countryFlag(),
      title: countryName(),
      onTap: () {
        eventController.add(ChooseCountryEvent(modelData));
      },
      trailing: countryDialCode(),
    );
  }

  Widget countryFlag() {
    return Image.asset(
      'assets/flags/${modelData.code.toLowerCase()}.png',
      width: 35,
      height: 24,
      fit: BoxFit.cover,
    );
  }

  Widget countryName() {
    return Text(
      modelData.name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget countryDialCode() {
    return Text(
      modelData.dialCode,
      style: const TextStyle(fontSize: 16),
    );
  }
}

