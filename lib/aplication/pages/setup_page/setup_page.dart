import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/constants.dart';
import 'package:postownik/aplication/core/page_config.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_button.dart';
import 'package:postownik/aplication/pages/common_widgets/custom_set_data_container/custom_set_data_container.dart';
import 'package:postownik/aplication/pages/generate_post/generate_post.dart';
import 'package:postownik/aplication/pages/home_page/home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  final TextEditingController _companySpecializationController =
  TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  static final pageConfig =
  PageConfig(icon: Icons.post_add, name: "setup_page", child: SetupPage());

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(title: const Text("Konfiguracja")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width / 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height / 30,
                ),
                CustomSetDataBox(
                  textController:
                  _companySpecializationController,
                  boxDescription: 'Napisz krótka czym się zajmujesz',
                  boxHint: "Mała firma zajmująca się pieczniem tortów",
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                CustomSetDataBox(
                    textController: _companyNameController,
                    boxDescription: "Podaj nazwę firmy",
                    boxHint: "Justynka Cakes"),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Dalej",
                    onPressed: () async {
                      try {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                        final firebaseUser =
                        prefs.getString(Constants.preffsFireStoreUserUuid);
                        final userDoc = FirebaseFirestore.instance
                            .collection('users')
                            .doc(firebaseUser);
                        final userSnapshot = await userDoc.get();

                        final facebookPageName =
                        prefs.getString(Constants.preffsFbManagedPageName);
                        final facebookPagesSnapshot =
                        userSnapshot.data()?['facebookPages'];

                        if (!facebookPagesSnapshot
                            .containsKey(facebookPageName)) {
                          final Map<String, dynamic> newFacebookPage = {
                            facebookPageName!: {
                              'companyName': _companyNameController.text,
                              'companySpecialization':
                              _companySpecializationController.text,
                            }
                          };
                          await userDoc.set(
                            {'facebookPages': newFacebookPage},
                            SetOptions(merge: true),
                          );
                          await prefs.setString(
                              Constants.preffsCompanySpecialization,
                              _companySpecializationController.text);
                          await prefs.setString(Constants.preffsCompanyName,
                              _companyNameController.text);
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                      context.go(
                          '/${HomePage.pageConfig.name}/${GeneratePostPage
                              .pageConfig.name}');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
