import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class DiseasesDetailsPage extends StatelessWidget {
  final String title;
  final String summary;

  DiseasesDetailsPage({
    super.key,
    required this.title,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: AppColor.skyPastelColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                summary,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
