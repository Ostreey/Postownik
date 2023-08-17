import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key, required this.URL, required this.size,
  });
  final String URL;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: URL == ''
            ? Image.asset('assets/blank_profile_pic.jpg', width: size, height: size)
            : Image.network(URL)
    );
  }
}