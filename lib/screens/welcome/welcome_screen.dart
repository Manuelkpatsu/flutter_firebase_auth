import 'package:flutter/material.dart';
import 'package:flutterfirebaseauth/generated/l10n.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.title),
      ),
      body: Center(
        child: Text(S.current.welcome),
      ),
    );
  }
}
