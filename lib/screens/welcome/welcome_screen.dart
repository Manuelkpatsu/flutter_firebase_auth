import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

import '../../locator.dart';
import 'welcome_bloc.dart';
import 'welcome_event.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final WelcomeBloc bloc;
  final eventController = StreamController<WelcomeEvent>();

  @override
  void initState() {
    bloc = get<WelcomeBloc>(param1: context, param2: eventController);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          backgroundImage(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              title(),
              phoneSignIn(),
            ],
          )
        ],
      ),
    );
  }

  Widget backgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome_image.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        S.current.title.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget phoneSignIn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 40,
      child: ElevatedButton(
        child: Text(
          S.current.phoneSignIn,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          eventController.add(GoToPhoneSignInScreenEvent());
        },
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black,
          primary: Colors.white,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
