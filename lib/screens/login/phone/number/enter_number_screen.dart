import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

import '../../../../locator.dart';
import 'enter_number_bloc.dart';
import 'enter_number_event.dart';
import 'enter_number_listenable.dart';

class EnterNumberScreen extends StatefulWidget {
  static const routeName = '/enter_phone_number';

  const EnterNumberScreen({Key? key}) : super(key: key);

  @override
  _EnterNumberScreenState createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  late final EnterNumberBloc bloc;
  final eventController = StreamController<EnterNumberEvent>();
  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    bloc = get<EnterNumberBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    phoneNumberController.dispose();
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
            verifyingPhoneNumberIndicator(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              enterNumberText(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  countryFlagImage(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: phoneNumberTextField(),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  youMayReceiveSMSText(),
                  const SizedBox(width: 20),
                  nextButton(),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget verifyingPhoneNumberIndicator() {
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
            return Visibility(
              visible: showProgress,
              child: child!,
            );
          },
        ),
      ),
    );
  }

  Widget enterNumberText() {
    return Text(
      S.of(context).enterPhoneNumber,
      style: const TextStyle(fontSize: 22, color: Colors.black),
    );
  }

  Widget countryFlagImage() {
    return InkWell(
      onTap: () => eventController.add(GoToSelectCountryScreenEvent()),
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<String>(
              valueListenable: bloc.countryFlagImage,
              builder: (context, countryCode, child) {
                return Image.asset(
                  //TODO Replace with country code picker
                  'assets/flags/${countryCode.toLowerCase()}.png',
                  width: 35,
                  height: 24,
                  fit: BoxFit.cover,
                );
              },
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget phoneNumberTextField() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ValueListenableBuilder<String>(
              valueListenable: bloc.countryDialCode,
              builder: (context, countryDialCode, child) {
                return Text(
                  countryDialCode,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                );
              }),
          const SizedBox(width: 5),
          Expanded(
            child: TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  hintText: S.of(context).phoneNumberHint,
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey.shade400),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                autofocus: true,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }

  Widget youMayReceiveSMSText() {
    return Expanded(
      child: Text(
        S.of(context).youMayReceiveSMS,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
      ),
    );
  }

  Widget nextButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(height: 45, width: 120),
      child: ValueListenableBuilder<bool>(
        valueListenable: bloc.nextButton,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).next, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward)
          ],
        ),
        builder: (context, enableButton, child) {
          return ElevatedButton(
            onPressed: enableButton
                ? () => eventController.add(
                      VerifyPhoneNumberEvent(
                        phoneNumberController.text.trim().toString(),
                      ),
                    )
                : null,
            child: child,
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          );
        },
      ),
    );
  }
}
