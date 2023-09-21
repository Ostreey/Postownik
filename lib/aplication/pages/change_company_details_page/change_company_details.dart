import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postownik/aplication/core/page_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_set_data_container/custom_set_data_container.dart';

class ChangeCompanyDetailsPage extends StatefulWidget {
   ChangeCompanyDetailsPage({super.key});
   static final pageConfig =
   PageConfig(icon: Icons.post_add, name: "change_company_details", child: ChangeCompanyDetailsPage());

  @override
  State<ChangeCompanyDetailsPage> createState() => _ChangeCompanyDetailsPageState();
}

class _ChangeCompanyDetailsPageState extends State<ChangeCompanyDetailsPage> {
  final TextEditingController _companySpecializationController =  TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                    text: "Zmień",
                    onPressed: () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                      final firebaseUser =
                      prefs.getString(Constants.preffsFireStoreUserUuid);
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(firebaseUser);

                      final facebookPageName =
                      prefs.getString(Constants.preffsFbManagedPageName);

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
                      context.pop();
                    }),
              ],
            ),
          ),
        )
      )
    );
  }
}
