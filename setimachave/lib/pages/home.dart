import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';
import 'package:setimachave/widgets/custom_buttom.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: Image.asset('assets/img/logo.png'),
          ),
          Text(
            "Sétima Chave",
            style: TextStyle(
              fontSize: 35.0,
              fontWeight: FontWeight.w300,
              fontFamily: 'Megrim'
            ),
          ),
          CustomButton(
            text: "Entrar",
            background: buttonColor,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}
