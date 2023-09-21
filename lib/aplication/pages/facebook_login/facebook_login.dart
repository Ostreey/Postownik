import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/domain/repositories/facebook_repository.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_button.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_snackbar.dart';
import 'package:postownik/aplication/pages/facebook_login/facebook_login_provider.dart';
import 'package:postownik/aplication/pages/setup_page/setup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../injection.dart';
import '../../core/page_config.dart';
import '../common_widgets/profile_pic.dart';
import '../generate_post/generate_post.dart';



class FacebookLogin extends ConsumerStatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  static final pageConfig = PageConfig(icon: Icons.post_add, name: "login", child: FacebookLogin());

  @override
  _FacebookLoginState createState() => _FacebookLoginState();
}

class _FacebookLoginState extends ConsumerState<FacebookLogin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    ref.listen(fbLoginProvider, (previous, next) {
      if(next is AsyncData){
        CustomSnackbar.show(context, "Zalogowano pomyślnie");
        context.pushReplacement("/facebook_pages");
      }
      if(next is AsyncError){
        debugPrintStack();
        CustomSnackbar.show(context, next.error.toString());
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Witamy w Postownik!", style: Theme.of(context).textTheme.headlineLarge,),
            SizedBox(height: 40,),
            Image.asset('assets/logo2.png', width: 200, height: 200,),
            SizedBox(height: 20,),

            CustomButton(
              isLoading: ref.watch(fbLoginProvider).isLoading,
              text: "Kontynuuj przez Facebook",
              onPressed: () async {
                ref.read(fbLoginProvider.notifier).login();
              },
            ),
          ],
        ),
      ),
          );
  }
}

