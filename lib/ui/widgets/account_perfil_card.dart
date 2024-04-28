

import 'package:flutter/material.dart';

class AccountPerfilCard extends StatelessWidget {
  const AccountPerfilCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.white,
      elevation:
          2, // Ajusta el nivel de elevación según sea necesario
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 16,
            ),
            SizedBox(width: 16),
            Text(
              'Hola, Jordan! 👋',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}