import 'package:flutter/material.dart';

class AssetImagePractics extends StatefulWidget {
  const AssetImagePractics({super.key});

  @override
  State<AssetImagePractics> createState() => _AssetImagePracticsState();
}

class _AssetImagePracticsState extends State<AssetImagePractics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text(
            "Assets",
            style: TextStyle(
                color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: Center(
          child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImagePage()));
              },
              child: Text(
                "Show Image",
                style: TextStyle(fontSize: 25),
              )),
        )));
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(),
      body: Center(child: Image.asset('assets/images/download.jpeg')),
    );
  }
}
