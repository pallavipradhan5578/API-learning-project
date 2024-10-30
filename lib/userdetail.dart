import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  var data;
  Future<void> getUserDetailAPi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      print('Data is loading');
    } else {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder(
          future: getUserDetailAPi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState) {
              return Text("data loding");
            }
            return ListView.builder(
                itemCount: data['users'].length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 150,
                            width: 150,
                            child: Image.network(
                                data['users'][index]['image'].toString())),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [SizedBox(height: 20,),
                            Text('ID: ${data['users'][index]['id']}',),

                            Text('Title: ${data['users'][index]['firstName']}',),
                            Text('Gender: ${data['users'][index]['gender']}',),
                            Text('Phone: ${data['users'][index]['phone']}',),
                            Text('Age: ${data['users'][index]['age']}',)
                          ]
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
