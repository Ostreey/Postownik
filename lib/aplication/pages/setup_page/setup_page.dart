import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/page_config.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_button.dart';
import 'package:postownik/aplication/pages/generate_post/generate_post.dart';
import 'package:postownik/aplication/pages/home_page/home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SetupPage extends StatelessWidget {
  final TextEditingController _companySpecializationController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  static final pageConfig = PageConfig(icon: Icons.post_add, name: "setup_page", child: SetupPage());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Konfiguracja")),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width / 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: size.height / 30,
            ),
            Material(
              elevation: 10,
              child: Container(
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Napisz krótko czym się zajmujesz",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 100,
                      maxLines: 2,
                      controller: _companySpecializationController,
                      decoration: const InputDecoration(
                          hintText: "Mała firma zajmująca się pieczniem tortów"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Material(
              elevation: 10,
              child: Container(
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Podaj nazwe swojej firmy",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 100,
                      maxLines: 2,
                      controller: _companyNameController,
                      decoration: const InputDecoration(hintText: "Netflix"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                text: "Dalej",
                onPressed: () async {
                  try {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('company_specialization',
                        _companySpecializationController.text);
                    await prefs.setString(
                        'company_name', _companyNameController.text);
                  } catch (e) {
                    print(e.toString());
                  }
                  context.go('/${HomePage.pageConfig.name}/${GeneratePostPage.pageConfig.name}');
                })
          ],
        ),
      ),
    );
  }
}
