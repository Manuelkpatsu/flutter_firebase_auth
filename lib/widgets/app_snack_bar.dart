import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar(String message, {Key? key})
      : super(key: key,
    content: Text(message, style: const TextStyle(color: Colors.white)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.black,
  );
}
