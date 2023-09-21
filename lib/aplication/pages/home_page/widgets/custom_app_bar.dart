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
    final urlPic = ref.watch(userPicUrlProvider);
    final companyName = ref.watch(pageNameProvider);
    debugPrint("urlPic: $urlPic");
    debugPrint("companyName: $companyName");
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(companyName),
      actions: [
        GestureDetector(
          onTap: () =>  Scaffold.of(context).openDrawer(),
            child: ProfilePic(URL: urlPic , size: 50)
        ),
      ],
    );
  }
}
