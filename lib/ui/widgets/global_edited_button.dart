import 'package:flutter/material.dart';

class GlobalEditedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double fontsize;
  final double width;
  final double height; 

  const GlobalEditedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.black,
    this.fontsize = 18,
    this.width = 220,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: fontsize,
            ),
      ),
    );
  }
}
