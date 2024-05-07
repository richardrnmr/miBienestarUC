import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mi_bienestar_uc/models/hospital.dart';
import 'package:mi_bienestar_uc/models/user_patient.dart';
import 'package:mi_bienestar_uc/pages/home_page.dart';
import 'package:mi_bienestar_uc/pages/login_page.dart';
import 'package:mi_bienestar_uc/ui/widgets/custom_show_dialog.dart';

class FirebaseHelper {

  //autenticacion de Firebase
  static Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // navega a la pantalla HomePage si la autenticación es exitosa
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: userCredential.user!.uid),
        ),
        (route) => false,
      );
    } catch (e) {
      // muestra un cuadro de diálogo con el mensaje de error
      showCustomDialog(
        title: 'Error de autenticación',
        // ignore: use_build_context_synchronously
        context: context,
        message: 'Usuario o contraseña incorrectos',
        onAccept: (){
          Navigator.pop(context);
        }
      );
    }
  }

  // registra usuario en Firebase
  static Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required int age,
    required String gender,
    required BuildContext context,
  }) async {
    try {
      // Registro en Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Guardar datos adicionales en Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'age': age,
        'gender': gender,
        'id': userCredential.user!.uid,
      });

      // muestra cuadro de dialogo con la confirmacion
      showCustomDialog(
        title: 'Confirmación',
        context: context,
        message: 'Registrado exitosamente exitosamente',
        onAccept: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(userId: userCredential.user!.uid),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      print('Error de registro: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // muestra un mensaje indicando que el usuario ya está registrado
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error de registro'),
                content: const Text(
                    'El correo electrónico ya ha sido registrado anteriormente.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cerrar'),
                  ),
                ],
              );
            },
          );
          return; 
        }
      }

      // muestra un mensaje de error genérico si no se puede determinar la causa exacta del error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error de registro'),
            content: const Text(
                'Hubo un error durante el registro. Por favor, inténtalo de nuevo más tarde.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  //chequea el usuario de Firebase
  static Future<bool> checkAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    return user != null;
  }

  // cierra sesion de Firebase
  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  // obtiene datos del usuario de Firestore
  static Future<UserPatient?> getUserData(String id) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.where('id', isEqualTo: id).get();

    // si no se encuentra ningún documento, devuelve null
    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    // si se encuentra un documento, devuelve el primer documento encontrado
    var doc = querySnapshot.docs.first;

    return UserPatient(
      email: doc['email'],
      name: doc['name'],
      id: doc['id'],
      gender: doc['gender'],
      age: doc['age'],
    );
  }

  static Future<List<Hospital>> getHospitals() async {
    try {
      // obtiene una referencia a la colección 'hospitals'
      CollectionReference hospitals =
          FirebaseFirestore.instance.collection('hospitals');

      // obtiene todos los documentos de la colección
      QuerySnapshot querySnapshot = await hospitals.get();

      // convierte los documentos en objetos Hospital y se almacena en una lista
      List<Hospital> listaHospitales = querySnapshot.docs.map((doc) {
        return Hospital(
          name: doc['name'],
          address: doc['address'],
          phone: doc['phone'],
        );
      }).toList();

      return listaHospitales;
    } catch (e) {
      print('Error al obtener los hospitales: $e');
      return []; 
    }
  }

  static Future<void> postProblem({
    required String reason,
    required String detail,
  }) async {
    try {
      // obtiene una referencia a la colección 'problems'
      CollectionReference problems =
          FirebaseFirestore.instance.collection('problems');

      // sube un documento con los campos reason y detail
      await problems.add({
        'reason': reason,
        'detail': detail,
      });
    } catch (e) {
      print('Error al subir el problema: $e');
    }
  }
}
