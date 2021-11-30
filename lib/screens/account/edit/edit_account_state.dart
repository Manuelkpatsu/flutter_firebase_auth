import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:flutterfirebaseauth/locator.dart';
import 'package:flutterfirebaseauth/widgets/app_snack_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';


import 'edit_account_bloc.dart';
import 'edit_account_builder.dart';
import 'edit_account_event.dart';
import 'edit_account_screen.dart';

class EditAccountState extends State<EditAccountScreen> {
  final logger = Logger();
  final eventController = StreamController<EditAccountEvent>();
  late final EditAccountBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = get<EditAccountBloc>(param1: context, param2: eventController);
    bloc
        .getEventStream<EditAccountStateEvent>()
        .listen((event) => handleEvent(event))
        .onError((error) {
      logger.e('Error responding to edit account state event', error);
    });
    bloc.init();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EditAccountBuilder(bloc);
  }

  /// Handles [EditAccountStateEvent]s
  void handleEvent(EditAccountStateEvent event) {
    switch (event.runtimeType) {
      case ShowSelectImageOptionsSheetEvent:
        showSelectImageOptionsSheet();
        break;
      case ShowSnackBarEvent:
        final showSnackBarEvent = event as ShowSnackBarEvent;
        ScaffoldMessenger.of(context).showSnackBar(
          AppSnackBar(showSnackBarEvent.message),
        );
        break;
    }
  }

  Future<T?> showSelectImageOptionsSheet<T>() {
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return IntrinsicHeight(
          child: Column(
            children: [
              updatePhotoTile(),
              takePhotoTile(),
              chooseFromLibraryTile(),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget updatePhotoTile() {
    return ListTile(
      title: Text(
        S.current.updatePhoto,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget takePhotoTile() {
    return ListTile(
      leading: const Icon(Icons.photo_camera, color: Colors.black),
      title: Text(
        S.current.takePhoto,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: () {
        bloc.addEvent(SelectImageEvent(ImageSource.camera));
      },
    );
  }

  Widget chooseFromLibraryTile() {
    return ListTile(
      leading: const Icon(Icons.photo, color: Colors.black),
      title: Text(
        S.current.chooseFromLibrary,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: () {
        bloc.addEvent(SelectImageEvent(ImageSource.gallery));
      },
    );
  }
}
