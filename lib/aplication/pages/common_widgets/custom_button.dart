import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, this.isLoading, required this.text, required this.onPressed});

  final Function onPressed;
  final bool? isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPressed(),
        child: isLoading ?? false
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white))
            : Text(text));
  }
}
