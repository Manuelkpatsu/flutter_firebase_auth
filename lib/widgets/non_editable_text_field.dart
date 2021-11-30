import 'package:flutter/material.dart';

class NonEditableTextField extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const NonEditableTextField({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: child,
      ),
    );
  }
}
