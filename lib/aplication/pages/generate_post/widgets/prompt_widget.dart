import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromptWidget extends ConsumerWidget {
  const PromptWidget({
    super.key,
    required TextEditingController promptController,
  }) : _promptController = promptController;

  final TextEditingController _promptController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return TextFormField(
      controller:_promptController,
      maxLines: 2,
      validator: (value){
        return (value == '') ? 'Wpisz temat postu' : null;
      },
      decoration: const InputDecoration(
          labelText: "Temat posta",
          hintText: "Czekoladowe ciasto z ozdobami w ksztalcie butelek"
      ),
    );
  }
}