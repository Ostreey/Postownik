import 'package:flutter/material.dart';
import 'package:postownik/aplication/core/page_config.dart';

class GenerateImagePage extends StatelessWidget {
  const GenerateImagePage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.image_rounded,
    name: "image",
    child: GenerateImagePage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Container(
        color: Colors.deepOrange,
      ),
    );
  }
}
