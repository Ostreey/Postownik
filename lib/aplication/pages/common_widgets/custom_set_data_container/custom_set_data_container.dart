
import 'package:flutter/material.dart';

class CustomSetDataBox extends StatelessWidget {
  const CustomSetDataBox({
    super.key,
    required TextEditingController textController, required this.boxDescription, required this.boxHint,
  }) : _companySpecializationController = textController;

  final TextEditingController _companySpecializationController;
  final String boxDescription;
  final String boxHint;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              boxDescription,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLength: 100,
              maxLines: 2,
              controller: _companySpecializationController,
              decoration:  InputDecoration(
                  hintText:
                  boxHint),
            ),
          ],
        ),
      ),
    );
  }
}
