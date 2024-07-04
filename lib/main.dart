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
  String _flag = '';
  List itemList = [];
  String androidIcon = '';
  String characterImage = '';
  List<String> imageList = [];

  ////////////////////////
  void _fetchItem() async {
    final characterName = Uri.encodeComponent(_controller.text);
    print(characterName);
    final response = await http.get(
      Uri.parse(
          'https://open.api.nexon.com/maplestory/v1/id?character_name=$characterName'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response.statusCode == 200) {
      print("200성공~~1");
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _ocid = data['ocid'] ?? 'OCID not found';
        _error = '';
      });
    } else {
      print('200이 아님');
      setState(() {
        _error = 'Failed to fetch OCID';
        _ocid = '';
      });
    }

    final response3 = await http.get(
      Uri.parse(
          'https://open.api.nexon.com/maplestory/v1/character/android-equipment?ocid=$_ocid'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response3.statusCode == 200) {
      print("200성공~~2");
      final Map<String, dynamic> data = json.decode(response3.body);
      setState(() {
        if (data['android_icon'] != null) {
          androidIcon = data['android_icon'];
        }
      });
    }

    final response4 = await http.get(
      Uri.parse(
          'https://open.api.nexon.com/maplestory/v1/character/basic?ocid=$_ocid'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response4.statusCode == 200) {
      print("200성공~~2");
      final Map<String, dynamic> data = json.decode(response4.body);
      setState(() {
        characterImage = data['character_image'];
      });
    }

    final response2 = await http.get(
      Uri.parse(
          'https://open.api.nexon.com/maplestory/v1/character/item-equipment?ocid=$_ocid'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response2.statusCode == 200) {
      print("200성공~~3");
      final Map<String, dynamic> data = json.decode(response2.body);
      setState(() {
        itemList = data['item_equipment'];
        imageList = List.filled(equipmentData.length, '');
        for (int i = 0; i < equipmentData.length; i++) {
          String equipmentName = equipmentData[i];
          for (Map item in itemList) {
            if (item['item_equipment_slot'] == equipmentName) {
              imageList[i] = item['item_icon'];
            }
          }
        }
        if (androidIcon != '') {
          imageList[27] = androidIcon;
        }

        _flag = 'a';
        _error = '';
      });
      if (_flag == 'a') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Equip(imageList: imageList, characterImage: characterImage),
          ),
        );
      }
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
                _fetchItem(); // Corrected: Call _fetchItem() with ()
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            if (imageList.isNotEmpty)
              Text(
                '',
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

const List<String> equipmentData = [
  '반지1',
  '',
  '망토',
  '',
  '엠블렘',
  '반지2',
  '펜던트',
  '얼굴장식',
  '',
  '뱃지',
  '반지3',
  '펜던트2',
  '눈장식',
  '귀고리',
  '훈장',
  '반지4',
  '무기',
  '상의',
  '어깨장식',
  '보조무기',
  '포켓 아이템',
  '벨트',
  '하의',
  '장갑',
  '망토',
  '신발',
  '',
  '안드로이드',
  '',
  '기계 심장',
];
