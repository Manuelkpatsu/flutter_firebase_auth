import 'dart:async';

import 'package:flutterfirebaseauth/model/country.dart';
import 'package:logger/logger.dart';

import '../phone_flow_coordinator.dart';
import 'select_country_tile_model_data.dart';
import 'select_country_tile_event.dart';

class SelectCountryTileBloc {
  final logger = Logger();
  final StreamController<SelectCountryTileEvent> _eventController;
  final PhoneFlowCoordinator _phoneFlowCoordinator;

  SelectCountryTileBloc(this._eventController, this._phoneFlowCoordinator) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => logger.e("Error handling event", error));
  }

  /// Handles [SelectCountryTileEvent]
  _handleEvent(SelectCountryTileEvent event) {
    switch (event.runtimeType) {
      case ChooseCountryEvent:
        final chooseCountryEvent = event as ChooseCountryEvent;
        _selectCountry(chooseCountryEvent.modelData);
        break;
    }
  }

  void _selectCountry(SelectCountryTileModelData modelData) {
    Country selectedCountry = Country(
      name: modelData.name,
      code: modelData.code,
      dialCode: modelData.dialCode,
    );
    _phoneFlowCoordinator.closeSelectCountryScreen(selectedCountry);
  }

  void dispose() {
    _eventController.close();
  }
}
