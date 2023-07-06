import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';
import 'package:setimachave/widgets/custom_buttom.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<int> _SendForm() async {
    int status = 400;
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      var body = {
        'name': name,
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('https://backend-flutter-app.fernandolucas8.repl.co/register'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setBool('loggedIn', true);
        status = response.statusCode;
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
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33.0),
                            child: Column(children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Por favor, insira seu nome';
                                  }
                                  // Você pode adicionar mais validações de email aqui
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
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
                                  // Você pode adicionar mais validações de email aqui
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
                      text: "Criar conta",
                      background: buttonColor,
                      onPressed: () async {
                        int res = await _SendForm();
                        if (res == 201) {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Deu tudo certo'),
                                  content: Text("Conta criada com sucesso! \nAgora faça login."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/login');
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
