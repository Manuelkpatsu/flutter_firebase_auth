import 'package:flutter/material.dart';

class SelectCountryScreen extends StatefulWidget {
  static const routeName = '/select_country';

  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Select Country Screen'),
      ),
    );
  }
}
