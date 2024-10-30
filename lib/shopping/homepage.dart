import 'package:flutter/material.dart';import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:pallaviapi/shopping/Userdetailpage.dart';
import 'package:pallaviapi/shopping/commenta_page.dart';
import 'package:pallaviapi/shopping/post_page.dart';
import 'package:pallaviapi/shopping/todo_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    UserdetailsScreen(),
    PostScreen(),
    CommentsScreen(),
    TodoScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Userdetails',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_rounded),
            label: 'Comments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Todos',
          ),
        ],
      ),
    );
  }
}







class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? products;

  Future<void> getUserApi() async {
    final response = await http.get(
        Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = jsonDecode(response.body)['products'];
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
      body: products == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: products!.length,
        itemBuilder: (context, index) {
          final product = products![index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Product Image
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      product['thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Category: ${product['category']}'),
                        Text('Price: \$${product['price']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}



