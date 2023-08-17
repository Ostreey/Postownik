import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generate_post_provider.dart';


class ResponseWidget extends ConsumerStatefulWidget {
  @override
  _ResponseWidgetState createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends ConsumerState<ResponseWidget> {

  final TextEditingController _responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _responseController.addListener(_onResponseTextChanged);
  }

  void _onResponseTextChanged() {
    final String newText = _responseController.text;
    debugPrint("text controller: $newText");
    ref.read(postMessageProvider.notifier).state = newText;
  }

  @override
  Widget build(BuildContext context) {
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
