import 'package:flutter/material.dart';

import 'enter_otp_arguments.dart';

class EnterOTPScreen extends StatefulWidget {
  final EnterOTPArguments arguments;

  const EnterOTPScreen(this.arguments, {Key? key}) : super(key: key);

  @override
  _EnterOTPScreenState createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('OTP Screen'),
      ),
    );
  }
}
