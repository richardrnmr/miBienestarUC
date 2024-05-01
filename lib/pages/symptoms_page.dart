import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:mi_bienestar_uc/core/helpers/checker_symptoms_helper.dart';
import 'package:mi_bienestar_uc/core/validators.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/edited_text_area.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';
import 'package:mi_bienestar_uc/ui/widgets/result_item.dart';

class SymptomsPage extends StatefulWidget {
  SymptomsPage({Key? key}) : super(key: key);

  @override
  _SymptomsPageState createState() => _SymptomsPageState();
}

class _SymptomsPageState extends State<SymptomsPage> {
  final TextEditingController symptomsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> results = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'DESCRIBE\nTUS\nSÍNTOMAS',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontSize: 56),
                          ),
                          TextSpan(
                            text: ' +',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Color(0xFFD6C731), // Color del +
                                  fontSize: 64,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: EditedTextArea(
                      enableText: !isLoading,
                      hintText: 'Por ejemplo: Tengo fiebre, tos, etc.',
                      controller: symptomsController,
                      validator: PersonalizedValidators.text,
                    ),
                  ),
                  GlobalEditedButton(
                    width: MediaQuery.of(context).size.width,
                    text: 'BUSCAR RESULTADOS',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        results = [];
                        final symptoms = symptomsController.text;
                        // Muestra el indicador de carga
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          // Espera a que la operación asíncrona se complete
                          final resultsFromApi =
                              await CheckerSymptomsHelper.analyzeSymptoms(
                                  symptoms);
                          // Oculta el indicador de carga
                          setState(() {
                            isLoading = false;
                            if (resultsFromApi != null) {
                              // Extrae los datos procesados
                              results = [
                                ...resultsFromApi['potentialCauses'],
                                '',
                              ];
                              // Elimina los elementos vacíos de la lista results
                              results.removeWhere((element) => element.isEmpty);
                            } else {
                              // Si no hay resultados, muestra un mensaje de error
                              results = ['No se encontraron resultados.'];
                            }
                          });
                        } catch (error) {
                          // Si ocurre un error, muestra un mensaje de error
                          setState(() {
                            isLoading = false;
                            results = [
                              'Hubo un error al buscar los resultados.'
                            ];
                          });
                        }
                      }
                    },
                    color: AppColor.yellowPastelColor,
                  ),
                  results.isEmpty
                      ? Column(
                          children: [
                            Center(
                                child: Lottie.asset(
                                    'assets/searchAnimation.json',
                                    height: 200)),
                            Text('¡Busca una respuesta a tus síntomas!')
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Posibles resultados',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                  if (isLoading)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(parent: ScrollPhysics()),
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ResultItem(name: results[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(30), // Radio para hacerlo redondo
          ),
          elevation: 1,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          backgroundColor: AppColor.blackparcialColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
