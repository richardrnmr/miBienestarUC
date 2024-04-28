import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/core/validators.dart';
import 'package:mi_bienestar_uc/pages/login_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/edited_text_form_field.dart';
import 'package:mi_bienestar_uc/ui/widgets/gender_drop_down_button.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final String genderController = 'Genero';

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
                const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    'REGISTRO',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 76,
                        ),
                  ),
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: ListView(
                      children: [
                        EditedTextFormField(
                          hintText: 'Ingrese correo',
                          controller: emailController,
                          validator: PersonalizedValidators.email,
                        ),
                        SizedBox(height: 24),
                        EditedTextFormField(
                          hintText: 'Ingrese DNI o carnet de extranjería',
                          controller: idController,
                          validator: PersonalizedValidators.number,
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(height: 24),
                        EditedTextFormField(
                          hintText: 'Ingrese contraseña',
                          controller: passwordController,
                          isPassword: true,
                          validator: PersonalizedValidators.password,
                        ),
                        SizedBox(height: 24),
                        EditedTextFormField(
                          hintText: 'Vuelve a escribir tu contraseña',
                          controller: password2Controller,
                          isPassword: true,
                          validator: (value) =>
                              PersonalizedValidators.passwordsMatch(
                                  value, passwordController.text),
                        ),
                        SizedBox(height: 24),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: EditedTextFormField(
                                hintText: 'Ingrese edad',
                                controller: ageController,
                                validator: PersonalizedValidators.age,
                                textInputType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: GenderDropDown(
                                genderController: genderController,
                                validator: PersonalizedValidators.dropdownValue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        GlobalEditedButton(
                          color: AppColor.yellowPastelColor,
                          text: 'REGISTRARSE',
                          fontsize: 22,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(genderController);
                              await FirebaseHelper.registerWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                                id: int.parse(idController.text),
                                age: int.parse(ageController.text),
                                gender: genderController,
                                context: context,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    GlobalEditedButton(
                        fontsize: 22,
                        text: 'INGRESAR',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        color: AppColor.skyPastelColor),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
