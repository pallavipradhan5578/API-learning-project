import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetApiExample extends StatefulWidget {
  const GetApiExample({super.key});

  @override
  State<GetApiExample> createState() => _GetApiExampleState();
}

class _GetApiExampleState extends State<GetApiExample> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "GET API EXAMPLE",
          style: TextStyle(color: Colors.limeAccent.shade700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("data loading");
                    }
                    return ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Card(color: Colors.blue.shade300,
                          child: Column(
                            children: [ReuableRow(title:'ID' ,value: data[index]['id'].toString(),),
                          ReuableRow(title: 'Username', value:  data[index]['username'].toString()),
                              ReuableRow(title: 'Name', value: data[index]['Name'].toString() ),
                              ReuableRow(title: 'Email', value: data[index]['email'].toString() ),
                              ReuableRow(title: 'Address', value: data[index]['address']['street'].toString()),
                              ReuableRow(title: 'Geo', value: data[index]['address']['geo']['lng'].toString()),
                              ReuableRow(title: 'Geo', value: data[index]['address']['geo']['lat'].toString())
                            ],
                          ),
                        ),
                      );
                    });
                  }))
        ],
      ),
    );
  }
}
class ReuableRow extends StatelessWidget {
  String title,value;
  ReuableRow({Key? key, required this.title,required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}

