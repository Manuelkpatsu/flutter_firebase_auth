import 'package:flutter/material.dart';

class EnterNumberScreen extends StatefulWidget {
  static const routeName = '/enter_phone_number';

  const EnterNumberScreen({Key? key}) : super(key: key);

  @override
  _EnterNumberScreenState createState() => _EnterNumberScreenState();
}

class _EnterNumberScreenState extends State<EnterNumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Number Screen'),
      ),
      body: const Center(
        child: Text('Phone Sign In'),
      ),
    );
  }
}
