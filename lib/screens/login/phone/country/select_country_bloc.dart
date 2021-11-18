import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:logger/logger.dart';

import 'select_country_domain_model.dart';
import 'select_country_event.dart';
import 'select_country_tile_model_data.dart';

class SelectCountryBloc extends ValueNotifier<List<SelectCountryTileModelData>> {
  final _logger = Logger();
  final StreamController<SelectCountryEvent> _eventController;
  final SelectCountryDomainModel _selectCountryDomainModel;
  List<SelectCountryTileModelData> _countries = [];

  SelectCountryBloc(this._eventController, this._selectCountryDomainModel) : super([]) {
    _eventController.stream
        .listen((event) => _handleEvent(event))
        .onError((error) => _logger.e('Error responding to event', error));

    _selectCountryDomainModel
        .getSelectCountryTileModelDataListStream()
        .listen((countries) {
      _countries = countries;
      value = countries;
    });
  }

  /// Handles [SelectCountryEvent]
  _handleEvent(SelectCountryEvent event) {
    switch (event.runtimeType) {
      case SearchCountryEvent:
        final searchCountryEvent = event as SearchCountryEvent;
        _search(searchCountryEvent.searchQuery);
        break;
      case ClearSearchQueryEvent:
        _clearSearchQuery();
        break;
    }
  }

  /// Searches the country list and returns
  /// countries that match the [searchQuery]
  void _search(String searchQuery) {
    final fuse = Fuzzy<SelectCountryTileModelData>(
      _countries,
      options: FuzzyOptions(
        threshold: 0.2,
        keys: [
          WeightedKey(
            getter: (i) => i.name,
            weight: 1,
            name: 'name',
          ),
        ],
      ),
    );

    final result = fuse.search(searchQuery);
    final filteredCountryList = result.map((r) => r.item).toList();
    value = filteredCountryList;
  }

  /// Resets the country list
  void _clearSearchQuery() {
    value = _countries;
  }

  @override
  void dispose() {
    _selectCountryDomainModel.dispose();
    super.dispose();
  }
}
