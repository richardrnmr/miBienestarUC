import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/apimedic_helper.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/models/diagnosis.dart';
import 'package:mi_bienestar_uc/models/symptom.dart';
import 'package:mi_bienestar_uc/models/user_patient.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';
import 'package:searchfield/searchfield.dart';
import 'package:velocity_x/velocity_x.dart';

class SymptomsApimedicPage extends StatefulWidget {
  final String userId;

  SymptomsApimedicPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<SymptomsApimedicPage> createState() => _SymptomsApimedicPageState();
}

class _SymptomsApimedicPageState extends State<SymptomsApimedicPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Symptom> _symptoms = [];
  String? token;
  UserPatient? userPatient;
  late List<Symptom> _filteredSymptoms = [];
  late final List<Symptom> _selectedSymptoms = [];
  late List<Diagnosis> _diagnoses = [];

  @override
  void initState() {
    _fetchData();
    _getuserData();
    super.initState();
    _filteredSymptoms = _symptoms;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getuserData() async {
    try {
      userPatient = await FirebaseHelper.getUserData(widget.userId);
    } catch (error) {
      print("Error al obtener datos del paciente: $error");
    }
  }

  Future<void> _fetchData() async {
    try {
      token = await ApiMedic.getToken();
      _symptoms = await ApiMedic.fetchSymptoms(token!, 'es-es');

      setState(() {});
    } catch (error) {}
  }

  Future<void> _getResults() async {
    final int age = calculateAge(userPatient!.age).toInt();
    try {
      final List<Diagnosis> diagnoses = await ApiMedic.fetchDiagnosis(
        token!,
        _selectedSymptoms,
        changeGender(userPatient!.gender),
        calculateAge(age),
      );
      setState(() {
        _diagnoses = diagnoses;
      });
    } catch (error) {
      print("Error al obtener el diagnostico: $error");
    }
  }

  void _showDiagnosisDetails(BuildContext context, Diagnosis diagnosis) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Detalles de diagnóstico'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre: ${diagnosis.issue.name}'),
              Text('Nombre del profesional: ${diagnosis.issue.profName}'),
              Text(
                  'Precisión: ${diagnosis.issue.accuracy.toStringAsFixed(2)}%'),
              Text('Especializacion: ${diagnosis.specialisations[0].name}'),
              // Agrega más detalles según tus necesidades
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                alignment: Alignment.topLeft,
                child: Text(
                  'DESCRIBE\nTUS SÍNTOMAS',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 56),
                ),
              ).p24(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SearchField<Symptom>(
                  controller: _searchController,
                  hint: 'Busca tus síntomas',
                  searchInputDecoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueGrey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow, width: 1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  maxSuggestionsInViewPort: 6,
                  suggestions: _filteredSymptoms
                      .map((symptom) => SearchFieldListItem<Symptom>(
                            symptom.name,
                            item: symptom,
                          ))
                      .toList(),
                  suggestionsDecoration: SuggestionDecoration(
                      color: AppColor.yellowPastelColor,
                      borderRadius: BorderRadius.circular(16)),
                  onSearchTextChanged: (query) {
                    setState(() {
                      _filteredSymptoms = _symptoms
                          .where((symptom) => symptom.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    });
                    if (_filteredSymptoms.isNotEmpty) {
                      return _filteredSymptoms
                          .map((symptom) => SearchFieldListItem<Symptom>(
                                symptom.name,
                                item: symptom,
                              ))
                          .toList();
                    } else {
                      return [];
                    }
                  },
                  onSuggestionTap: (SearchFieldListItem<Symptom> suggestion) {
                    bool alreadySelected = _selectedSymptoms
                        .any((symptom) => symptom.id == suggestion.item!.id);

                    if (!alreadySelected) {
                      setState(() {
                        _selectedSymptoms.add(suggestion.item!);
                      });
                    }
                    FocusScope.of(context).unfocus();
                    _searchController.clear();
                  },
                ),
              ),
              Container(
                height: 200,
                width: context.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _selectedSymptoms.map((symptom) {
                      return Container(
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColor.yellowPastelColor,
                          borderRadius: BorderRadius.circular(64),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              symptom.name,
                              style: const TextStyle(fontSize: 13),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSymptoms.remove(symptom);
                                });
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              iconSize: 20,
                            ),
                          ],
                        ).pOnly(left: 16),
                      );
                    }).toList(),
                  ),
                ),
              ).p24(),
              GlobalEditedButton(
                color: AppColor.yellowPastelColor,
                width: context.screenWidth,
                text: 'BUSCAR RESULTADOS',
                onPressed: () async {
                  if (userPatient == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Error: No se ha encontrado información del usuario'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  _getResults();
                },
              ).px24(),
              if (_diagnoses.isEmpty || _diagnoses == [])
                const Text(
                  'Todavía no hay información relevante',
                  style: TextStyle(fontSize: 16),
                ).p24()
              else
                Container(
                  height: 360,
                  width: context.screenWidth,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _diagnoses.length,
                    itemBuilder: (context, index) {
                      final diagnosis = _diagnoses[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        surfaceTintColor: Colors.white,
                        margin:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(diagnosis.issue.name),
                          subtitle: Text(diagnosis.issue.profName),
                          trailing: Text(
                            '${diagnosis.issue.accuracy.toStringAsFixed(2)}%',
                            style: TextStyle(
                                color: diagnosis.issue.accuracy > 50
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 16),
                          ),
                          onTap: () {
                            _showDiagnosisDetails(context, diagnosis);
                          },
                        ),
                      );
                    },
                  ),
                ).p8()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(30),
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

String changeGender(String gender) {
  if (gender == 'Masculino') {
    return 'male';
  } else {
    return 'female';
  }
}

int calculateAge(int birthYear) {
  final currentYear = DateTime.now().year;
  return currentYear - birthYear;
}
