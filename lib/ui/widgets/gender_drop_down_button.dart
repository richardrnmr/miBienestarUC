import 'package:flutter/material.dart';

class GenderDropDown extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController? genderController;

  const GenderDropDown({
    Key? key,
    required this.genderController,
    required this.validator,
  }) : super(key: key);

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      value: 'Genero',
      validator: widget.validator,
      icon: const Icon(Icons.arrow_drop_down),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14),
      items: [
        const DropdownMenuItem(
          value: 'Genero',
          child: Text('Genero'),
        ),
        const DropdownMenuItem(
          value: 'Masculino',
          child: Text('Masculino'),
        ),
        const DropdownMenuItem(
          value: 'Femenino',
          child: Text('Femenino'),
        ),
        const DropdownMenuItem(
          value: 'Otro',
          child: Text('Otro'),
        ),
      ],
      onChanged: (value) {
        widget.genderController?.text = value!;
      },
    );
  }
}
