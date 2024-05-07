import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class SloganCard extends StatelessWidget {
  const SloganCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.yellowPastelColor,
              AppColor.greenPastelColor,
              AppColor.skyPastelColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '¿BUSCAS\nINFORMACIÓN\nMÉDICA?',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 28,
                        color: Colors.black,
                      ),
                ),
              ),
              const SizedBox(width: 20),
              Image.asset(
                'assets/doctor_image.png', // Ruta de la imagen
                fit: BoxFit.fitHeight,
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
