import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mi_bienestar_uc/pages/instructions_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';

class InstructionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InstructionsPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.yellowPastelColor,
              AppColor.greenPastelColor,
              AppColor.skyPastelColor
            ],
          ),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/instructions_image.svg',
                cacheColorFilter: true,
                height: 24,
                color: Color(0xFF9568F4),
              ),
              SizedBox(width: 16),
              Text('VER INSTRUCCIONES',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
