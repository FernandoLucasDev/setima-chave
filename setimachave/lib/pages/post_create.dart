import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';
import 'package:setimachave/widgets/custom_buttom.dart';
import 'package:http/http.dart' as http;

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  int count = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future<int> _SendForm() async {
    int status = 400;
    print('Antes de entrar no if');
    if (_formKey.currentState!.validate()) {
      print('entrou no if');
      String title = _titleController.text;
      String content = _contentController.text;
      String id = '13';

      var body = {
        'title': title,
        'text': content,
        'id': id,
      };

      print(body);

      var response = await http.post(
        Uri.parse(
            'https://backend-flutter-app.fernandolucas8.repl.co/new-post'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        status = response.statusCode;
      }
    }
    print(_titleController.text);
    print(_contentController.text);
    print(status);
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
                    child: Center(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                count == 0 ? "Título" : "Texto da postagem",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromARGB(255, 187, 187, 187)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Text(
                                  _titleController.text,
                                  style: TextStyle(
                                      fontFamily: 'Lora',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                                  child: count == 0
                                      ? TextFormField(
                                          controller: _titleController,
                                          decoration: const InputDecoration(
                                            labelText: 'Título da postagem',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                count = 0;
                                              });
                                              return 'Por favor, insira seu um título';
                                            }
                                            return null;
                                          },
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 50.0),
                                          child: TextFormField(
                                            controller: _contentController,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                              labelText: 'Texto da postagem',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Por favor, insira seu um texto para a postagem';
                                              }
                                              return null;
                                            },
                                          ),
                                        )),
                              count == 0
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 50.0),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            count = 1;
                                          });
                                        },
                                        child: Text('Próximo'),
                                      ),
                                    )
                                  : CustomButton(
                                      text: "Postar",
                                      background: buttonColor,
                                      onPressed: () async {
                                        var res = await _SendForm();
                                        if (res == 201) {
                                          showCupertinoModalPopup(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Post criado! ✨'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '/main');
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      })
                            ],
                          )),
                    ),
                  ),
                ])
          ),
      ),
    );
  }
}
