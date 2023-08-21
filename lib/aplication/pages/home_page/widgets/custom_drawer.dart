import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/pages/common_widgets/profile_pic.dart';

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
              title: const Text('Logout'),
              leading: const Icon(Icons.login_outlined),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        )
    );
  }
}