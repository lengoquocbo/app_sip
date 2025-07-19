import 'package:flutter/material.dart';

class CallButton extends StatelessWidget {
  final VoidCallback onPressed;

  CallButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.phone),
        onPressed: onPressed,
      ),
    );
  }
}
