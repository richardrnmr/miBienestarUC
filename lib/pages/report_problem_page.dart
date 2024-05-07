import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/core/validators.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/custom_show_dialog.dart';
import 'package:mi_bienestar_uc/ui/widgets/edited_text_area.dart';
import 'package:mi_bienestar_uc/ui/widgets/edited_text_form_field.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ReportProblemPage extends StatelessWidget {
  const ReportProblemPage({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REPORTAR\nPROBLEMA',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 36,
                    ),
              ).p16(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    EditedTextFormField(
                      hintText: 'Escribe la razón',
                      controller: reasonController,
                      validator: PersonalizedValidators.text,
                    ),
                    SizedBox(height: 24),
                    EditedTextArea(
                      hintText: 'Detállanos el problema :c',
                      controller: detailsController,
                      minLines: 3,
                      enableText: true,
                      colorbside: AppColor.skyblueColor,
                      validator: PersonalizedValidators.text,
                    ),
                    SizedBox(height: 24),
                    GlobalEditedButton(
                        text: 'ENVIAR',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showCustomDialog(
                              title: 'Confirmación',
                              context: context,
                              message: '¿Estás seguro de enviar este reporte?',
                              onAccept: () {
                                FirebaseHelper.postProblem(
                                    reason: reasonController.text,
                                    detail: detailsController.text);
                                reasonController.clear();
                                detailsController.clear();
                                Navigator.pop(context);
                                showCustomDialog(
                                  title: 'Confirmación',
                                  context: context,
                                  message: 'Enviado exitosamente',
                                  onAccept: () {
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              onCancel: () {},
                            );
                          }
                        },
                        color: AppColor.skyPastelColor)
                  ],
                ),
              ).p16(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 1,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: AppColor.blackparcialColor,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ).p16(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
