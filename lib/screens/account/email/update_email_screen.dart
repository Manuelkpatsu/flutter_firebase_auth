import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

import '../../../locator.dart';
import '../../validator.dart';
import 'update_email_argument.dart';
import 'update_email_bloc.dart';
import 'update_email_event.dart';
import 'update_email_listenable.dart';

class UpdateEmailScreen extends StatefulWidget {
  final UpdateEmailArgument argument;

  const UpdateEmailScreen(this.argument, {Key? key}) : super(key: key);

  @override
  _UpdateEmailScreenState createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  late final UpdateEmailBloc bloc;
  final eventController = StreamController<UpdateEmailEvent>();
  late final TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController(text: widget.argument.currentEmail);
    bloc = get<UpdateEmailBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(children: [AppBar(), progressIndicator()]),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              updateEmailText(),
              const SizedBox(height: 15),
              emailTextFormField(),
              const SizedBox(height: 20),
              updateButton(),
            ],
          ),
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
            backgroundColor: Colors.white,
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

  Widget updateEmailText() {
    return Text(
      S.current.updateEmail,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  Widget emailTextFormField() {
    return Form(
      key: formKey,
      child: TextFormField(
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: emailController,
        validator: Validator.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: InputBorder.none,
          hintText: S.of(context).enterEmailAddress,
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
                final updateEmailEvent = UpdateUserEmailEvent(
                  emailController.text.trim().toString(),
                );
                eventController.add(updateEmailEvent);
              }
            }
                : null,
          );
        },
      ),
    );
  }
}
