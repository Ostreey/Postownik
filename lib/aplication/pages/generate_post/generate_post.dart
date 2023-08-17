import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/aplication/core/page_config.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_snackbar.dart';
import 'package:postownik/aplication/pages/common_widgets/profile_pic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets/custom_button.dart';
import 'generate_post_provider.dart';
import 'widgets/prompt_widget.dart';
import 'widgets/response_widget.dart';


class GeneratePostPage extends ConsumerWidget {
   GeneratePostPage({super.key});
  final TextEditingController _promptController = TextEditingController();

  static final pageConfig = PageConfig(icon: Icons.post_add, name: "post", child: GeneratePostPage());



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResponse = ref.watch(promptProvider);
    ref.watch(sharedPreferencesProvider);
    ref.listen(publishOnFbPageProvider, (previous, next) {
      if (next is AsyncError){
        CustomSnackbar.show(context, next.error.toString());
      }
    });
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text(ref.watch(pageNameProvider)),
          actions: [
      ProfilePic(URL: ref.watch(userPicUrlProvider), size: 50)
          ],

        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width / 20,
            vertical: size.width / 15,
          ),
          child: Column(
            children: [
              PromptWidget(promptController: _promptController),
              SizedBox(height: 20,),
              CustomButton(
                isLoading: asyncResponse.isLoading,
                text: "Generuj post",
                onPressed: () {
                  ref.read(promptProvider.notifier).generate(_promptController.text);
                },
              ),
              ResponseWidget(),
              SizedBox(height: 20,),
              CustomButton(text: "Udostępnij na Facebook", onPressed: (){
                  ref.read(publishOnFbPageProvider.notifier).publish();
              })
            ],
          ),
        ),
      ),
    );
  }
}
