import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/pages/symptoms_apimedic_page.dart';
import 'package:mi_bienestar_uc/pages/help_page.dart';
import 'package:mi_bienestar_uc/pages/report_problem_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/account_perfil_card.dart';
import 'package:mi_bienestar_uc/ui/widgets/actions_button.dart';
import 'package:mi_bienestar_uc/ui/widgets/describe_symptoms_button.dart';
import 'package:mi_bienestar_uc/ui/widgets/instructions_card.dart';
import 'package:mi_bienestar_uc/ui/widgets/search_diseases_button.dart';
import 'package:mi_bienestar_uc/ui/widgets/slogan_card.dart';

class HomePage extends StatelessWidget {
  final String userId;

  HomePage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AccountPerfilCard(userId: userId),
                    ElevatedButton(
                      onPressed: () {
                        FirebaseHelper.signOut(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(12),
                        backgroundColor: Colors.white,
                        elevation: 2,
                      ),
                      child: Icon(
                        Icons.logout,
                        color: AppColor.blackparcialColor,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                SloganCard(),
                SizedBox(height: 16),
                Row(
                  children: [
                    DescribeSymptomsButton(),
                    SizedBox(width: 8),
                    SearchDiseasesButton(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    '¿Cómo funciona nuestra app?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
                InstructionsCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Otras acciones:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                        ),
                  ),
                ),
                ActionsButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpPage(),
                        ),
                      );
                    },
                    svgPicture: 'help_image.svg',
                    colorSvg: Colors.green,
                    text: 'NÚMEROS DE AYUDA'),
                SizedBox(height: 16),
                ActionsButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SymptomsApimedicPage(userId: userId),
                        ),
                      );
                    },
                    svgPicture: 'problem_image.svg',
                    colorSvg: Colors.red,
                    text: 'REPORTAR PROBLEMA'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
