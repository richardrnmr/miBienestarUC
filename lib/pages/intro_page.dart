import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:mi_bienestar_uc/pages/login_page.dart';
import 'package:mi_bienestar_uc/ui/general/colors.dart';
import 'package:mi_bienestar_uc/ui/widgets/global_edited_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  AppColor.yellowPastelColor,
                  AppColor.greenPastelColor,
                  AppColor.skyPastelColor,
                  AppColor.greenPastelColor,
                  AppColor.yellowPastelColor,
                ])),
          ),
          AnimatedPositioned(
            height: MediaQuery.sizeOf(context).height,
            duration: Duration(milliseconds: 500),
            top: _isButtonPressed ? -MediaQuery.sizeOf(context).height : 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'DESCRIBE',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: 76,
                                ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '+',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: 76,
                                  color: AppColor.skyblueColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resuelve tus dudas con',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                            Text(
                              'nuestros diagnósticos',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'TUS',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: 76,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "\\",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    fontSize: 76, color: AppColor.skyblueColor),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'SÍNTOMAS',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  fontSize: 76,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Únete a la comunidad de estudiantes\nal pendiente de su salud',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        SizedBox(height: 16),
                        GlobalEditedButton(
                          fontsize: 22,
                            text: '¡EMPIEZA YA!',
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) => LoginPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset(0.0, 0.0))
                                          .animate(animation),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            color: AppColor.yellowPastelColor),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Lottie.asset('assets/robotAnimation.json',
                                width: 200),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isButtonPressed = !_isButtonPressed;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(), // Botón circular
                                padding:
                                    EdgeInsets.all(16), // Padding para el botón
                                backgroundColor: AppColor
                                    .blackparcialColor, // Color de fondo negro
                              ),
                              child: Icon(
                                Icons
                                    .arrow_downward, // Icono de flecha hacia abajo
                                color: Colors.white, // Color del icono blanco
                                size: 24, // Tamaño del icono
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //segunda pantalla

          AnimatedPositioned(
            height: MediaQuery.sizeOf(context).height,
            duration: Duration(milliseconds: 500),
            bottom: _isButtonPressed ? 0 : -MediaQuery.sizeOf(context).height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: AppColor.yellowPastelColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(164))),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "\\",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                          fontSize: 76,
                                          color: AppColor.skyblueColor),
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'ACERCA',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontSize: 76,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '¿Te sientes mal y no estás seguro de qué podría ser?\n¡No te preocupes! Con nuestra app obtendrás respuestas instantáneas a tus síntomas.\nNuestra aplicación está diseñada para hacer observaciones sobre tus síntomas y proporcionarte un diagnóstico aproximado.',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'CONTACTO',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: 76,
                              ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '+',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontSize: 76,
                                color: AppColor.skyblueColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // LLevar al numero del lider
                      print('oaaaa');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Quieres saber más de nosotros?\nSaber de nuestra iniciativa?',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          'Contáctanos',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16,
                                    color: AppColor.skyblueColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isButtonPressed = !_isButtonPressed;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16),
                            backgroundColor: AppColor.blackparcialColor,
                          ),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 80),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (_, __, ___) => LoginPage(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                              begin: Offset(1.0, 0.0),
                                              end: Offset(0.0, 0.0))
                                          .animate(animation),
                                      child: child,
                                    );
                                  },
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(16),
                            backgroundColor: AppColor.blackparcialColor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
