import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';
import 'package:tuple/tuple.dart';

import '../../../../locator.dart';
import 'enter_otp_arguments.dart';
import 'enter_otp_bloc.dart';
import 'enter_otp_event.dart';
import 'enter_otp_listenable.dart';

class EnterOTPScreen extends StatefulWidget {
  final EnterOTPArguments arguments;

  const EnterOTPScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  late final EnterOTPBloc bloc;
  final eventController = StreamController<EnterOTPEvent>();
  final otpController = TextEditingController();

  @override
  void initState() {
    bloc = get<EnterOTPBloc>(
      param1: context,
      param2: Tuple2(eventController, widget.arguments),
    );
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(),
              const SizedBox(height: 10),
              enterCodeText(),
              const SizedBox(height: 15),
              smsCodeTextFormField(),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: <Widget>[
                      resendCodeButton(),
                      resendCodeInText(),
                    ],
                  ),
                  const SizedBox(width: 20),
                  nextButton()
                ],
              ),
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
            minHeight: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          builder: (context, show, child) {
            return Visibility(
              visible: show,
              child: child!,
            );
          },
        ),
      ),
    );
  }

  Widget titleText() {
    return Text(
      S.of(context).verifyTitle,
      style: const TextStyle(fontSize: 22, color: Colors.black),
    );
  }

  Widget enterCodeText() {
    return Text(
      S.of(context).enterOTP(widget.arguments.phoneNumber),
      maxLines: 2,
      style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
    );
  }

  Widget smsCodeTextFormField() {
    return ValueListenableBuilder<bool>(
      valueListenable: bloc.smsCodeTextFormField,
      builder: (context, enable, child) {
        return TextFormField(
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: otpController,
          readOnly: enable,
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 5,
          ),
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: InputBorder.none,
            hintText: S.of(context).otpHint,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade400,
              letterSpacing: 0.5,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
          ],
        );
      },
    );
  }

  Widget resendCodeButton() {
    return ValueListenableBuilder<Tuple2<bool, bool>>(
      valueListenable: bloc.resendCodeButton,
      child: Text(
        S.of(context).resendCode,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
        ),
      ),
      builder: (context, tuple, child) {
        return Visibility(
          visible: tuple.item1,
          child: GestureDetector(
            onTap: tuple.item2
                ? () {
              otpController.clear();
              eventController.add(ResendCodeEvent());
            }
                : null,
            child: child,
          ),
        );
      },
    );
  }

  Widget resendCodeInText() {
    return ValueListenableBuilder<Tuple2<bool, int>>(
      valueListenable: bloc.resendCodeInText,
      builder: (context, tuple, child) {
        return Visibility(
          visible: tuple.item1,
          child: Text(
            S.of(context).resendCodeIn(
              tuple.item2.toString().padLeft(2, '0'),
            ),
            style: const TextStyle(color: Colors.green),
          ),
        );
      },
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
        builder: (context, enable, child) {
          return ElevatedButton(
            child: child,
            onPressed: enable
                ? () {
              eventController.add(SignInWithSMSCodeEvent(otpController.text));
            }
                : null,
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          );
        },
      ),
    );
  }
}
