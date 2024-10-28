import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiGImage extends StatefulWidget {
  const ApiGImage({super.key});

  @override
  State<ApiGImage> createState() => _ApiGImageState();
}

class _ApiGImageState extends State<ApiGImage> {
  var data;
  Future<void> getUserApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown.shade400,
        title: Text("Get api with image",style: TextStyle(color: Colors.lime),),centerTitle: true,
      ),body: Expanded(
        child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("data loading");
                    }
                    return ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [ReuableRow(title:'ID' ,value: data[index]['id'].toString(),),
                            ReuableRow(title: 'AlbumId', value:  data[index]['albumId'].toString()),
                            ReuableRow(title: 'Title', value: data[index]['title'].toString() ),Container(
                        padding: EdgeInsets.all(8.0),
                        child: Image.network(
                          data[index]['thumbnailUrl'],
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                            ))

                          ],
                        ),
                      );
                    });
                  }))
        ],
            ),
      ),
    );
  }
}class ReuableRow extends StatelessWidget {
  String title,value;
  ReuableRow({Key? key, required this.title,required this.value}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title),
          Expanded(child: Text(value,overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,))
        ],
      ),
    );
  }
}

