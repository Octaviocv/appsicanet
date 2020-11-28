import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goToLogin();
    });
    super.initState();
  }

  void goToLogin() {
    Future.delayed(
        Duration(seconds: 5), () => Navigator.pushNamed(context, 'login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BounceInUp(
      child: inicio(),
      duration: Duration(seconds: 3),
    ));
  }

  Widget inicio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/SicanetSoftwareSC_LogoHorizontal chico.jpg'),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Cargando Aplicación')],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }
}
