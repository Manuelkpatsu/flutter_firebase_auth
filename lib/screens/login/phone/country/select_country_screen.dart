import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

import '../../../../locator.dart';
import 'select_country_bloc.dart';
import 'select_country_event.dart';
import 'select_country_tile.dart';
import 'select_country_tile_model_data.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  late final SelectCountryBloc bloc;
  final eventController = StreamController<SelectCountryEvent>();
  final searchTextEditingController = TextEditingController();

  @override
  void initState() {
    bloc = get<SelectCountryBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectCountryText(),
          Container(
            color: Colors.grey.shade200,
            margin: const EdgeInsets.only(left: 16, top: 8, right: 16),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                searchIcon(),
                const SizedBox(width: 10),
                searchTextField(),
                const SizedBox(width: 5),
                clearSearchQueryButton(),
              ],
            ),
          ),
          Expanded(
            child: countryList(),
          ),
        ],
      ),
    );
  }

  Widget selectCountryText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        S.of(context).selectCountry,
        style: const TextStyle(fontSize: 22),
      ),
    );
  }

  Widget searchIcon() {
    return const Icon(
      Icons.search,
      size: 25,
      color: Colors.black54,
    );
  }

  Widget searchTextField() {
    return Expanded(
      child: TextFormField(
        controller: searchTextEditingController,
        autofocus: false,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: S.of(context).searchForCountry,
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade500),
        ),
        onChanged: (searchQuery) {
          eventController.add(SearchCountryEvent(searchQuery));
        },
      ),
    );
  }

  Widget clearSearchQueryButton() {
    return IconButton(
      icon: const Icon(
        Icons.cancel,
        size: 20,
        color: Colors.black54,
      ),
      onPressed: () {
        if (searchTextEditingController.text.isNotEmpty) {
          searchTextEditingController.clear();
          eventController.add(ClearSearchQueryEvent());
        }
      },
      splashRadius: 20,
    );
  }

  Widget countryList() {
    return ValueListenableBuilder<List<SelectCountryTileModelData>>(
      valueListenable: bloc,
      builder: (context, modelDataList, child) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(height: 0),
          itemCount: modelDataList.length,
          itemBuilder: (context, index) {
            return SelectCountryTile(modelDataList[index], context);
          },
        );
      },
    );
  }
}
