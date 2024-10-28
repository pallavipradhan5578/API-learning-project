import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  var data;
  Future<void> getUserAPi() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Get Api",
        ),
        centerTitle: true,
      ),body: FutureBuilder(future: getUserAPi(), builder: (context,snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){return Text("Data loading");
    }return ListView.builder(itemCount: data.length,itemBuilder: (context,index){
      return Card(
        child: Expanded(
          child: Column(
            children: [
              ReusableRow(title: 'Id', value: data[index]['id'].toString()),

              ReusableRow(title:"Price", value: data[index]['price'].toString()),ReusableRow(title: "Title", value: data[index]['title'].toString()),
            ],
          ),
        ),
      );
        });

      }),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

