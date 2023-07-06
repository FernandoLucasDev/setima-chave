import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final background;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.background,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
        style: ElevatedButton.styleFrom(
            primary: background,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: buttonColor))),
      ),
    );
  }
}