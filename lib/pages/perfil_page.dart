import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mi_bienestar_uc/models/user_patient.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';

class PerfilPage extends StatelessWidget {
  final UserPatient userPatient;
  PerfilPage({
    super.key,
    required this.userPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getProfileIcon(userPatient.gender),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nombre:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      userPatient.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      userPatient.email,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Género:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      userPatient.gender,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edad:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      userPatient.age.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GlobalEditedButton(
                      width: MediaQuery.sizeOf(context).width,
                      text: 'VOLVER',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: AppColor.greenPastelColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getProfileIcon(String gender) {
    switch (gender) {
      case 'Masculino':
        return Center(
            child: Lottie.asset('assets/manAnimation.json', height: 250));
      case 'Femenino':
        return Center(
            child: Lottie.asset('assets/womanAnimation.json', height: 250));
      case 'Otro':
        return Center(
            child: Lottie.asset('assets/otherAnimation.json', height: 250));
      default:
        return Center(
            child: Lottie.asset('assets/otherAnimation.json', height: 250));
    }
  }
}
