import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'equip.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  String _ocid = '';
  String _error = '';

  void _fetchOcid() async {
    final characterName = Uri.encodeComponent(_controller.text);
    print(characterName);
    final response = await http.get(
      Uri.parse('http://localhost:8081/getOcid2?characterName=$characterName'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response.statusCode == 200) {
      print("200성공~~");
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _ocid = data['cl'] ?? 'OCID not found';
        _error = '';
      });
    } else {
      print('200이 아님');
      setState(() {
        _error = 'Failed to fetch OCID';
        _ocid = '';
      });
    }
  }

  ////////////////////////
  void _fetchItem() async {
    final characterName = Uri.encodeComponent(_controller.text);
    print(characterName);
    final response = await http.get(
      Uri.parse('http://localhost:8081/getOcid2?characterName=$characterName'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response.statusCode == 200) {
      print("200성공~~");
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _ocid = data['cl'] ?? 'OCID not found';
        _error = '';
      });
    } else {
      print('200이 아님');
      setState(() {
        _error = 'Failed to fetch OCID';
        _ocid = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Web Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Character Name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _fetchOcid;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Equip(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            if (_ocid.isNotEmpty)
              Text(
                'OCID: $_ocid',
                style: TextStyle(fontSize: 20.0),
              ),
            if (_error.isNotEmpty)
              Text(
                'Error: $_error',
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
