import 'package:appsicanet/src/services/users_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loggedIn = false;
  String codigosms;

  UsersService serviciousuario = UsersService();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController phonecontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.blueAccent, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                ) //
              ]),
              child: Column(
                children: [
                  Text(
                    'Verificando tu Número',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Recibiras un mensaje de texto con el código de verificación',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    controller: phonecontroller,
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Celular',
                      prefix: Text('+52'),
                      icon: Icon(Icons.phone_android),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      bool existe = await serviciousuario
                          .existeNumCel('+52${phonecontroller.text}');
                      if (existe) {
                        requestCode('+52${phonecontroller.text}');
                        print('EL CODIGO ES $codigosms');
                      } else {
                        //showSnackBar();
                        // Navigator.pushNamed(context, 'registro');
                        print("No existe");
                      }
                    },
                    child: Text('Continuar'),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: codigosms != null
                    ? Column(
                        children: [
                          TextField(
                            controller: codecontroller,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'codigo',
                              icon: Icon(Icons.phone_android),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              singInCode(codecontroller.text, codigosms);
                            },
                            child: Text('Login'),
                          ),
                        ],
                      )
                    : Text('ss')),
          ],
        ),
      ),
    );
  }

  void showSnackBar() {
    final SnackBar snackBar = SnackBar(
        content: Text('Este numero no esta registrado, debes Registrarlo'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    Navigator.pushNamed(context, 'registro');
  }

  void requestCode(String numberPhone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: numberPhone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential phoneAuthCredential) =>
            print('Sign up with phone complete'),
        verificationFailed: (FirebaseAuthException error) =>
            print('error message is ${error.message}'),
        codeSent: (String verificationId, [int forceResendingToken]) {
          print('verificationId is $verificationId');
          setState(() {
            codigosms = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String codigo) {
          print('TERMINA EL TIEMPO $codigo');
        });
  }

  singInCode(String code, String verificationId) async {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    final User user =
        (await FirebaseAuth.instance.signInWithCredential(authCreds)).user;
    if (user != null) {
      //loginProvider.login();
      //final userLoggedin = await serviciousuario.getUser(phonecontroller.text);
      //loginProvider.usuario = userLoggedin;

      Navigator.pushNamed(context, 'home');
    } else {
      print('Error de subscripción');
    }
  }
}
