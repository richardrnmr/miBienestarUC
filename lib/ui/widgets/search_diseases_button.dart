import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mi_bienestar_uc/pages/diseases_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class SearchDiseasesButton extends StatelessWidget {
  const SearchDiseasesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DiseasesPage()),
          );
        },
        style: ElevatedButton.styleFrom(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            backgroundColor: AppColor.skyPastelColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              // SVG en la esquina superior derecha
              Positioned(
                top: 8,
                right: 0,
                child: SvgPicture.asset(
                  'assets/medicine_image.svg',
                  cacheColorFilter: true,
                  height: 44,
                  color: const Color(0xFF00A9C2),
                ),
              ),
              // Texto alineado a la izquierda
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'BUSCAR\nRECETAS Y\nENFERMEDADES',
                  textAlign: TextAlign.left,
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
