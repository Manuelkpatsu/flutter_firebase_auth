import 'dart:async';

import 'package:flutterfirebaseauth/repository/country_repository.dart';

import 'select_country_tile_model_data.dart';

class SelectCountryDomainModel {
  final _selectCountryModelDataStreamController =
      StreamController<List<SelectCountryTileModelData>>();
  final CountryRepository _countryRepository;

  SelectCountryDomainModel(this._countryRepository);

  Stream<List<SelectCountryTileModelData>> getSelectCountryTileModelDataListStream() {
    if (!_selectCountryModelDataStreamController.hasListener) {
      _refreshData();
    }
    return _selectCountryModelDataStreamController.stream.distinct();
  }

  void _refreshData() {
    _countryRepository.getCountries().then((countries) {
      List<SelectCountryTileModelData> countryList = countries
          .map((country) => SelectCountryTileModelData(
                code: country.code,
                name: country.name,
                dialCode: country.dialCode,
              ))
          .toList();
      _selectCountryModelDataStreamController.add(countryList);
    });
  }

  void dispose() {
    _selectCountryModelDataStreamController.close();
  }
}
