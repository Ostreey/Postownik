import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/pages/common_widgets/profile_pic.dart';
import 'package:postownik/domain/entities/fb_pages_entity/fb_pages_entity.dart';

class ListElement extends ConsumerWidget {
  ListElement({required this.pageProperties});
  FbPageProperties pageProperties;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ProfilePic(URL: pageProperties.picUrl, size: 50),
        SizedBox(width: 20,),
        Text(pageProperties.name),
      ],
    );
  }


}
