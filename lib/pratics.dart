import 'package:flutter/material.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({super.key});

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  dynamic arrStudentName = [
    "Sona",
    "Pihu",
    "Ruhi",
    "Niya",
    "Mannat",
    "Dua",
    "Barkkat",
    "Nur"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show the dialog to add a new name
              showDialog(
                context: context,
                builder: (context) {
                  String newName = ""; // Variable to store the input name
                  return AlertDialog(
                    title:  Text("Add Name"),
                    content: TextField(
                      onChanged: (value) {
                        newName = value; // Update name as user types
                      },
                      decoration: InputDecoration(hintText: "Enter name"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (newName.isNotEmpty) {
                            setState(() {
                              arrStudentName.add(newName); // Add new name to the list
                            });
                          }
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Submit"),
                      ), TextButton(
                        onPressed: () {
                          if (newName.isNotEmpty) {
                            setState(() {
                              arrStudentName.add(newName); // Add new name to the list
                            });
                          }
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Exit"),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              arrStudentName[index],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
        itemCount: arrStudentName.length,
        itemExtent: 100,
      ),
    );
  }
}
