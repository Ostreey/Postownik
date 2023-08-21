import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/pages/common_widgets/profile_pic.dart';
import 'package:postownik/aplication/pages/generate_post/generate_post_provider.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Postownik"),
      actions: [
        GestureDetector(
          onTap: () =>  Scaffold.of(context).openDrawer(),
            child: ProfilePic(URL: ref.watch(userPicUrlProvider), size: 50)
        ),
      ],
    );
  }
}
