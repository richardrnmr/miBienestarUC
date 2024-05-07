import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:velocity_x/velocity_x.dart';

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
            Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 24),
            ).p16(),
            Text(
              summary,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
            ).p16(),
          ],
        ),
      ),
    );
  }
}
