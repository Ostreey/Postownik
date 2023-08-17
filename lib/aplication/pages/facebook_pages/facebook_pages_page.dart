import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/aplication/core/page_config.dart';
import 'package:postownik/aplication/pages/facebook_pages/facebook_pages_provider.dart';
import 'package:postownik/aplication/pages/facebook_pages/widgets/list_elements.dart';
import 'package:postownik/aplication/pages/facebook_pages/widgets/pages_list.dart';
import 'package:postownik/aplication/pages/setup_page/setup_page.dart';
import 'package:postownik/main.dart';

import '../common_widgets/custom_snackbar.dart';

class FacebookPagesPage extends ConsumerWidget {
  const FacebookPagesPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(saveToSharedPreffsTwoProvider, (previous, next) {
      if(next is AsyncData){
       context.push("/${SetupPage.pageConfig.name}");
      }
      if(next is AsyncError){
        CustomSnackbar.show(context, next.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Wybierz swoją stronę"),
      ),
      body: Center(
        child: PagesList(),
      ),
    );
  }
}


