import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<dynamic>? data; // Store the list of products

  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/comments'));

    if (response.statusCode == 200) {

      setState(() {
        data = jsonDecode(response.body)['comments'];
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('API Data'),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ReusableRow(
                  title: 'Id:',
                  value: data![index]['id'].toString(),
                ),
                ReusableRow(
                  title: 'Body:',
                  value: data![index]['body'].toString(),
                ),
                ReusableRow(
                  title: 'postsId',
                  value: data![index]['postsId'].toString(),
                ),
                ReusableRow(
                  title: 'Likes',
                  value: data![index]['likes'].toString(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;

  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text(value)],
      ),
    );
  }
}

