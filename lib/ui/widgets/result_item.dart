import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class ResultItem extends StatelessWidget {
  final String name;

  const ResultItem({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        color: Color(0xFFFFFFFB),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          splashColor: AppColor.yellowPastelColor,
          onTap: () {
            // Navegar a otra página aquí
            // Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              name.toUpperCase(),
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
