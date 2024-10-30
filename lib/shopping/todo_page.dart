import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<dynamic>? data;

  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/todos'));

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body)['todos'];
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
                  title: 'Todo:',
                  value: data![index]['todo'].toString(),
                ),
                ReusableRow(
                  title: 'Completed',
                  value: data![index]['completed'].toString(),
                ),
                ReusableRow(
                  title: 'UserId',
                  value: data![index]['userId'].toString(),
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
        children: [
          Text(title),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
