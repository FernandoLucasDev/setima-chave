import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardPost extends StatelessWidget {
  final int id;
  final String title;
  final String postText;

  CardPost({required this.id, required this.title, required this.postText});

  void _showModal(BuildContext context, String text) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Lora'
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: 150.0,
            height: 260.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF044BAE),
                  Color(0xFFC86CE5),
                ],
              ),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(30),
              child: InkWell(
                onTap: () {
                  _showModal(context, postText);
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                          child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 22.0, 
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lora'
                              ),
                        ),
                      )
                  ),
                ),
              ),
            )),
          ),
        ));
  }
}
