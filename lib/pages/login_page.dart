import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/core/validators.dart';
import 'package:mi_bienestar_uc/pages/register_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/edited_text_form_field.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                AppColor.yellowPastelColor,
                AppColor.greenPastelColor,
                AppColor.skyPastelColor,
                AppColor.greenPastelColor,
                AppColor.yellowPastelColor,
              ])),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 90, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'INGRESAR',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: 76,
                              ),
                    ),
                    SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          EditedTextFormField(
                            hintText: 'Ingrese correo electrónico',
                            controller: emailController,
                            validator: PersonalizedValidators.email,
                          ),
                          SizedBox(height: 24),
                          EditedTextFormField(
                            hintText: 'Ingrese contraseña',
                            controller: passwordController,
                            isPassword: true,
                            validator: PersonalizedValidators.password,
                          ),
                          SizedBox(height: 24),
                          GlobalEditedButton(
                            color: AppColor.yellowPastelColor,
                            text: 'INGRESAR',
                            fontsize: 22,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await FirebaseHelper.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        '¿Todavía no tienes una cuenta?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      GlobalEditedButton(
                          fontsize: 22,
                          text: 'REGISTRARSE',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          color: AppColor.skyPastelColor),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
