import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'NÚMEROS DE AYUDA',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 36,
                    ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('hospitals')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Construye la lista utilizando los datos de Firestore
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var hospitalData = snapshot.data!.docs[index];
                      return _buildHospitalListItem(
                        context,
                        hospitalData['name'],
                        hospitalData['address'],
                        hospitalData['phone'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalListItem(
      BuildContext context, String nombre, String direccion, String telefono) {
    return ListTile(
      title: Text(
        nombre,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(direccion),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            onPressed: () {
              _launchPhone(telefono);
            },
          ),
        ],
      ),
    );
  }

  void _launchPhone(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}
