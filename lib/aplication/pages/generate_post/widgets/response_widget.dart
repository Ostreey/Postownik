import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generate_post_provider.dart';


class ResponseWidget extends ConsumerWidget {

  final TextEditingController _responseController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(promptProvider).whenData((value) => _responseController.text = value.toString());
    ref.listen(promptProvider, (previous, next) {
      if(next is AsyncError){
        print(next.error.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
      }
    });
    return TextField(
      decoration: const InputDecoration(
        labelText: "Wygenerowana odpowiedź"
      ),
      maxLines: 8,
      controller: _responseController,
    );
  }
}
