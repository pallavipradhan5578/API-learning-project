import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  String responseMessage = '';

  // Function to make a DELETE request
  Future<void> deleteData(int id) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'); // Sample API

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_token', // Replace with your token if required
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          responseMessage = 'Item with ID $id deleted successfully';
        });
      } else {
        setState(() {
          responseMessage = 'Failed to delete item. Status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        responseMessage = 'An error occurred: $error';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DELETE API Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                // Here we call deleteData() with the ID of the item we want to delete
                deleteData(1); // Example: Delete item with ID 1
              },
              child: Text('Delete Item with ID 1'),
            ),
            SizedBox(height: 20),
            Text(
              responseMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
