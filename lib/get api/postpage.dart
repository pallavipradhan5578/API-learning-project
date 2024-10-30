import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Postpage extends StatefulWidget {
  const Postpage({super.key});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  var data;

  Future<void> getUserDetailAPi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/posts'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
      });
      print('Data is loading');
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Post Data"),
      ),
      body: FutureBuilder(
        future: getUserDetailAPi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator());
          }
          if (data == null || data['posts'] == null) {
            return Center(child: Text('No data available'));
          }
          return ListView.builder(
            itemCount: data['posts'].length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${data['posts'][index]['id']}'),

                    //  Text('Title: ${data['posts'][index]['title']}'),
                      //Text('Likes: ${data['posts']['reactions'][index]['likes']}',),
                     /// Text('Dislikes: ${data['posts'][index]['reactions']['age']}',)

                      //Text('Reactions: ${data['posts'][index]['reactions']}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
