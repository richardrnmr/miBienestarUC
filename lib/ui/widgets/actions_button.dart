import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionsButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String svgPicture;
  final Color colorSvg;
  final String text;
  final Color? backgroundColor;

  const ActionsButton({
    Key? key,
    required this.onPressed,
    required this.svgPicture,
    required this.colorSvg,
    required this.text,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _ActionsButtonState createState() => _ActionsButtonState();
}

class _ActionsButtonState extends State<ActionsButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/${widget.svgPicture}',
                cacheColorFilter: true,
                height: 24,
                color: widget.colorSvg,
              ),
              const SizedBox(width: 16),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
