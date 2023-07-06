import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:setimachave/widgets/card_post.dart';

class PostsList extends StatefulWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    var url = Uri.parse('https://backend-flutter-app.fernandolucas8.repl.co/posts');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      List<dynamic> jsonData = json.decode(jsonResponse);
      return jsonData.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Erro na requisição. Código de status: ${response.statusCode}');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     fetchData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                String title = data[index]['title'];
                String text = data[index]['post_text'];
                int id = data[index]['id'];
                return CardPost(id: id, title: title, postText: text);
              },
            );
          } else {
            return Center(
              child: Text('Nenhum dado encontrado.'),
            );
          }
        },
      ),
    );
  }
}
