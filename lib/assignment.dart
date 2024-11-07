import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Assignment extends StatefulWidget {
  const Assignment({super.key});

  @override
  State<Assignment> createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {

  List movieList=[];
  bool isRequesting=false;
  Future<void> getUserApi({String query = 'Inception'}) async {
    isRequesting = true;
    setState(() {});

    final response = await http.get(
        Uri.parse('https://www.omdbapi.com/?apikey=720ddd7c&s=$query')
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Corrected the condition to check if the response is "True"
      if (data['Response'] == "True") {
        movieList = data['Search'];
      } else {
        movieList = [];
      }
    } else {
      movieList = [];
    }

    isRequesting = false;
    setState(() {});
  }

  @override
  void initState() {
    getUserApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

          appBar: AppBar(
            title: Text("Movie Search"),
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: Expanded(
              child: Column(
                children: [
                  TextField(
                    onChanged: (val){
                      print("$val");
                      if(val!=''){
                        getUserApi(query: val);
                      }else{
                        getUserApi();
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Search for a movie",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      // Handle the search logic here
                    },
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child:
                    isRequesting ?Center(
                      child: CircularProgressIndicator(),
                    ):
                        movieList.isEmpty?Center(
                          child: Text("Not found"),
                        ):

                    ListView.builder(
                      itemCount: movieList.length,
                      itemBuilder: (context, index) {
                        final movie = movieList[index];
                        return Card(
                          child: ListTile(
                            leading: SizedBox(
                              width: 200,  // Set the desired width
                              height: 450, // Set the desired height
                              child: Image.network(
                                movie["Poster"]!,
                                fit: BoxFit.cover, // Adjust how the image should fit within the box
                              ),
                            ),
                            title: Text(movie["Title"]!),
                            subtitle: Text("Year: ${movie["Year"]}"),
                          ),

                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
    }
}
