import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:mi_bienestar_uc/core/helpers/medline_plus_helper.dart';
import 'package:mi_bienestar_uc/pages/diseases_details_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class DiseasesPage extends StatefulWidget {
  DiseasesPage({super.key});

  @override
  State<DiseasesPage> createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {}

  void _performSearch(String searchText) {
    if (searchText.isNotEmpty) {
      MedlinePlusHelper.searchMedlinePlus(searchText).then((results) {
        setState(() {
          _searchResults = results;
        });
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'BUSCA\nRECETAS Y\n',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 56),
                      ),
                      TextSpan(
                        text: '\\',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: AppColor.skyblueColor, // Color del +
                                  fontSize: 54,
                                ),
                      ),
                      TextSpan(
                        text: 'ENFERMEDADES',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 56),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: _performSearch,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                      ),
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Buscar alguna enfermedad...',
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: AppColor.skyblueColor,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0), // Aumenté el relleno vertical
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColor.skyblueColor,
                      ), // Cambia el color del borde al tener el foco
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              _buildSearchResults(),
            ],
          ),
        ),
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
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

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Column(
        children: [
          Center(
              child: Lottie.asset('assets/sleepAnimation.json', height: 200)),
          Text('¡Al parecer no hay resultados aún!')
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resultados de la búsqueda:',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                ),
          ),
          SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              final result = _searchResults[index];
              // Procesar el texto para eliminar etiquetas HTML
              String title = _removeHtmlTags(result['title']);
              String summary = _removeHtmlTags(result['summary']);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Text(title),
                  tileColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiseasesDetailsPage(
                                title: title,
                                summary: summary,
                              )),
                    );
                  },
                ),
              );
            },
          ),
        ],
      );
    }
  }

// Función para eliminar etiquetas HTML del texto
  String _removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
