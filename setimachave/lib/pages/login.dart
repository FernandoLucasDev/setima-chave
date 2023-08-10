import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';
import 'package:setimachave/widgets/custom_buttom.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<int> _SendForm() async {
    int status = 400;
    final String username;
    final String useremail;
    final int userid;

    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      var body = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('https://backend-flutter-app.fernandolucas8.repl.co/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        status = response.statusCode;
        var resBody = response.body;
        var jsonBody = jsonDecode(resBody);
        prefs.setBool('loggedIn', true);
        prefs.setInt('userId', jsonBody['id']);
        prefs.setString('userEmail', jsonBody['email']);
        prefs.setString('userName', jsonBody['name']);
      }
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    width: 70.0,
                  ),
                  Text(
                    "Faça login",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
                    child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33.0),
                          child: Column(children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                          ]),
                        )),
                  ),
                  CustomButton(
                    text: "Fazer login",
                    background: buttonColor,
                    onPressed: () async {
                      int res = await _SendForm();
                      if (res == 200) {
                        Navigator.pushNamed(context, '/main');
                      } else {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Oops!'),
                                content: Text(
                                    "Algo deu errado! \nVerifique seu user e senha! \nCalma, vibrações positivas 🌟"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text('Tentar novamente'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                  Text("Ou"),
                  CustomButton(
                    text: "Criar conta",
                    background: buttonColorSecondary,
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
