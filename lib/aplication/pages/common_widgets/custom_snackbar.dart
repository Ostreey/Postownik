import 'package:flutter/material.dart';


class CustomSnackbar extends StatelessWidget {

  static void show(BuildContext context, String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.secondary
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Return an empty container as this is just a utility class
  }
}