import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RadioWidgetExample(),
    );
  }
}

class RadioWidgetExample extends StatefulWidget {
  @override
  _RadioWidgetExampleState createState() => _RadioWidgetExampleState();
}

class _RadioWidgetExampleState extends State<RadioWidgetExample> {

  int? _selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey,
        title: Text('Radio Widget Example'),centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text('Female'),
            leading: Radio<int>(
              value: 1,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Male'),
            leading: Radio<int>(
              value: 2,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Other'),
            leading: Radio<int>(
              value: 3,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selected Option: $_selectedOption',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
