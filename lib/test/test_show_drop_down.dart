import 'package:flutter/material.dart';

class TestShowDropDownScreen extends StatefulWidget {
  @override
  _TestShowDropDownScreenState createState() => _TestShowDropDownScreenState();
}

class _TestShowDropDownScreenState extends State<TestShowDropDownScreen> {
  String selectedValue = 'Option 1'; // Default selected value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dropdown Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showDropdown();
              },
              child: Text('Show Dropdown'),
            ),
            SizedBox(height: 20),
            Text('Selected Value: $selectedValue'),
          ],
        ),
      ),
    );
  }

  void _showDropdown() {
    // Create a list of dropdown items
    List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

    // Show the dropdown
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: DropdownButton<String>(
            value: selectedValue,
            items: options.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedValue = value ?? '';
                Navigator.of(context).pop(); // Close the dropdown
              });
            },
          ),
        );
      },
    );
  }
}
