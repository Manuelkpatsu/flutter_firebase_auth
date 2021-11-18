import 'package:flutter/material.dart';

abstract class SelectCountryEvent {}

@immutable
class SearchCountryEvent extends SelectCountryEvent {
  final String searchQuery;

  SearchCountryEvent(this.searchQuery);
}

class ClearSearchQueryEvent extends SelectCountryEvent {}
