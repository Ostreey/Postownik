import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/aplication/pages/change_company_details_page/change_company_details.dart';
import 'package:postownik/aplication/pages/common_widgets/profile_pic.dart';
import 'package:postownik/aplication/pages/facebook_login/facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child:Image.asset('assets/logo2.png', width: 100, height: 100)
              ),
            ),
            ListTile(
              title: const Text('Zmień opis firmy'),
              leading: const Icon(Icons.settings),
              onTap: () async{
                context.pushNamed(ChangeCompanyDetailsPage.pageConfig.name);
              },
            ),
            ListTile(
              title: const Text('Wyloguj'),
              leading: const Icon(Icons.login_outlined),
              onTap: () async{
                SharedPreferences preffs = await SharedPreferences.getInstance();
                preffs.setString(Constants.preffsCompanySpecialization, "");
                preffs.setString(Constants.preffsCompanyName, "");
                context.goNamed(FacebookLogin.pageConfig.name);
              },
            ),
          ],
        )
    );
  }
}