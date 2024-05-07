import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mi_bienestar_uc/pages/symptoms_apimedic_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class DescribeSymptomsButton extends StatelessWidget {
  final String userId;

  DescribeSymptomsButton({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SymptomsApimedicPage(userId: userId)),
          );
        },
        style: ElevatedButton.styleFrom(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            backgroundColor: AppColor.yellowPastelColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              // SVG en la esquina superior derecha
              Positioned(
                top: 8,
                left: 0,
                child: SvgPicture.asset(
                  'assets/stethoscope_image.svg',
                  cacheColorFilter: true,
                  height: 44,
                  color: Color(0xFFD6C731),
                ),
              ),
              // Texto alineado a la izquierda
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'DESCRIBE\nTUS\nSÍNTOMAS',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
