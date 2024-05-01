import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/pages/home_page.dart';
import 'package:mi_bienestar_uc/pages/intro_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/general/fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundColor,
        textTheme: TextTheme(
          headlineLarge: unicaOneStyle,
          bodyLarge: openSansStyle,
        ),
      ),
      home: FutureBuilder(
        future: FirebaseHelper.checkAuth(),
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              String userId = FirebaseAuth.instance.currentUser!.uid;
              return HomePage(userId: userId);
            } else {
              return IntroPage();
            }
          }
        },
      ),
    );
  }
}
