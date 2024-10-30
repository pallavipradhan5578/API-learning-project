import 'package:flutter/material.dart';import 'package:http/http.dart'as http;import 'dart:convert';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {List<dynamic>? data; // Store the list of products

Future<void> getUserApi() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/posts'));

  if (response.statusCode == 200) {

    setState(() {
      data = jsonDecode(response.body)['posts'];
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
                  title: 'Title:',
                  value: data![index]['title'].toString(),
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
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), Text(value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),

     ],
        ),

    );
  }
}