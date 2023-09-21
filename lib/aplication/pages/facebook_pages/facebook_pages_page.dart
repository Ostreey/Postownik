import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets/custom_snackbar.dart';
import '../generate_post/generate_post.dart';
import '../home_page/home_page.dart';

class FacebookPagesPage extends ConsumerWidget {
  const FacebookPagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(saveToSharedPreffsTwoProvider, (previous, next) async {
      if (next is AsyncData) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final firebaseUser = prefs.getString(Constants.preffsFireStoreUserUuid);
        final userDoc = FirebaseFirestore.instance.collection('users').doc(firebaseUser);
        final userSnapshot = await userDoc.get();
        final facebookPagesSnapshot = userSnapshot.data()?['facebookPages'];
        final facebookPageName = prefs.getString(Constants.preffsFbManagedPageName);
        if (facebookPagesSnapshot.containsKey(facebookPageName)){
          final Map<String, dynamic> facebookPages = facebookPagesSnapshot[facebookPageName];
          final companyName = facebookPages['companyName'];
          final companySpecialization = facebookPages['companySpecialization'];
          await prefs.setString(
              Constants.preffsCompanySpecialization, companySpecialization);
          await prefs.setString(Constants.preffsCompanyName, companyName);
          context.go(
              '/${HomePage.pageConfig.name}/${GeneratePostPage.pageConfig.name}');
        } else{
          context.push("/setup_page");
        }
        }

      if (next is AsyncError) {
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
