import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_button.dart';

import '../../common_widgets/custom_snackbar.dart';
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
    ref.listen(publishOnFbPageProvider, (previous, next) {
      if(next is AsyncData){
        CustomSnackbar.show(context, "Post opublikowany na Facebooku");
      }
      if(next is AsyncError){
        debugPrint(next.error.toString());
        CustomSnackbar.show(context, next.error.toString());
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
        CustomButton(
            isLoading: ref.watch(publishOnFbPageProvider).isLoading,
            text: "Udostępnij na Facebook",
            onPressed: (){
          ref.read(publishOnFbPageProvider.notifier).publish(_responseController.text);
        })
      ],
    );
  }
}
