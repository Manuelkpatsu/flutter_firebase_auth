import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

import '../../../locator.dart';
import '../../validator.dart';
import 'update_name_argument.dart';
import 'update_name_bloc.dart';
import 'update_name_event.dart';
import 'update_name_listenable.dart';

class UpdateNameScreen extends StatefulWidget {
  final UpdateNameArgument argument;

  const UpdateNameScreen(this.argument, {Key? key}) : super(key: key);

  @override
  _UpdateNameScreenState createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final eventController = StreamController<UpdateNameEvent>();
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final UpdateNameBloc bloc;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.argument.currentName);
    bloc = get<UpdateNameBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            AppBar(),
            progressIndicator(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(),
            const SizedBox(height: 15),
            fullNameTextFormField(),
            const SizedBox(height: 20),
            updateButton(),
          ],
        ),
      ),
    );
  }

  Widget progressIndicator() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ValueListenableBuilder<bool>(
          valueListenable: bloc.progressIndicator,
          child: const LinearProgressIndicator(
            backgroundColor: Colors.transparent,
            minHeight: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          builder: (context, showProgress, child) {
            return Visibility(visible: showProgress, child: child!);
          },
        ),
      ),
    );
  }

  Widget titleText() {
    return Text(
      S.current.fullName,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  Widget fullNameTextFormField() {
    return Form(
      key: formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: true,
        controller: nameController,
        validator: Validator.name,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          hintText: S.current.enterFullName,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget updateButton() {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ValueListenableBuilder<bool>(
        valueListenable: bloc.nextButton,
        child: Text(
          S.current.update.toUpperCase(),
          style: const TextStyle(fontSize: 16),
        ),
        builder: (context, enableButton, child) {
          return ElevatedButton(
            child: child,
            onPressed: enableButton
                ? () {
              if (formKey.currentState!.validate()) {
                final updateNameEvent = UpdateUserNameEvent(
                  nameController.text.trim().toString(),
                );
                eventController.add(updateNameEvent);
              }
            }
                : null,
          );
        },
      ),
    );
  }
}
