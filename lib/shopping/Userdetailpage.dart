import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserdetailsScreen extends StatefulWidget {
  const UserdetailsScreen({super.key});

  @override
  State<UserdetailsScreen> createState() => _UserdetailsScreenState();
}

class _UserdetailsScreenState extends State<UserdetailsScreen> {
  var data;
  Future<void> getUserDetailAPi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body.toString());
      });
      print('Data is loading');
    } else {
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetailAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: data['users'].length,
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                      data['users'][index]['image'].toString()),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),
                    Text('ID: ${data['users'][index]['id']}'),
                    Text(
                        'First Name: ${data['users'][index]['firstName']}'),
                    Text('Gender: ${data['users'][index]['gender']}'),
                    Text('Phone: ${data['users'][index]['phone']}'),
                    Text('Age: ${data['users'][index]['age']}'),

                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
