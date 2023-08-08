import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postownik/aplication/core/page_config.dart';

import '../common_widgets/custom_button.dart';
import 'generate_post_provider.dart';
import 'widgets/prompt_widget.dart';
import 'widgets/response_widget.dart';


class GeneratePostPage extends ConsumerWidget {
   GeneratePostPage({super.key});
  final TextEditingController _promptController = TextEditingController();

  static final pageConfig = PageConfig(icon: Icons.post_add, name: "post", child: GeneratePostPage());



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResponse = ref.watch(promptProvider);

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Align(alignment: Alignment.center, child: Text("Postownik")),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width / 20,
            vertical: size.width / 15,
          ),
          child: Column(
            children: [
              PromptWidget(promptController: _promptController),
              CustomButton(
                isLoading: asyncResponse.isLoading,
                text: "Generuj post",
                onPressed: () {
                  ref.read(promptProvider.notifier).generate(_promptController.text);
                },
              ),
              ResponseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
