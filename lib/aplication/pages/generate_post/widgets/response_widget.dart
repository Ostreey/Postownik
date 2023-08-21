import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_button.dart';

import '../generate_post_provider.dart';


class ResponseWidget extends ConsumerStatefulWidget {
  @override
  _ResponseWidgetState createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends ConsumerState<ResponseWidget> {

  final TextEditingController _responseController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    ref.watch(promptProvider).whenData((value) => _responseController.text = value.toString());
    ref.listen(promptProvider, (previous, next) {
      if(next is AsyncError){
        print(next.error.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!")));
      }
    });
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: "Wygenerowana odpowiedź"
          ),
          maxLines: 8,
          controller: _responseController,
        ),
        SizedBox(height: 20,),
        CustomButton(text: "Udostępnij na Facebook", onPressed: (){
          ref.read(publishOnFbPageProvider.notifier).publish(_responseController.text);
        })
      ],
    );
  }
}
