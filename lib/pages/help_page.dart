import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/core/helpers/firebase_helper.dart';
import 'package:mi_bienestar_uc/models/hospital.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NÚMEROS DE\nAYUDA',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 36,
                  ),
            ).p24(),
            Expanded(
              child: FutureBuilder<List<Hospital>>(
                future: FirebaseHelper.getHospitals(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Hospital>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var hospital = snapshot.data![index];
                      return _buildHospitalListItem(
                        context,
                        hospital.name,
                        hospital.address,
                        hospital.phone,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 1,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: AppColor.blackparcialColor,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ).p16(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget _buildHospitalListItem(
      BuildContext context, String nombre, String direccion, String telefono) {
    return ListTile(
      title: Text(
        nombre,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(direccion),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(
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
