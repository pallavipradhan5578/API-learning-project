import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetApiPractices extends StatefulWidget {
  const GetApiPractices({super.key});

  @override
  State<GetApiPractices> createState() => _GetApiPracticesState();
}

class _GetApiPracticesState extends State<GetApiPractices> {
  List<dynamic>? data;

  Future<void> getUserApi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {

      setState(() {
        data = jsonDecode(response.body)['products'];
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
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
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
                ReusableRow(
                  title: 'Category:',
                  value: data![index]['category'].toString(),
                ),
                ReusableRow(
                  title: 'Price:',
                  value: data![index]['price'].toString(),
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
