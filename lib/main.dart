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
  String power = '';
  String world = '';
  String level = '';
  String exp = '';
  String job = '';
  String name = '';
  List<String> imageList = [];

  ////////////////////////
  void _fetchItem() async {
    name = _controller.text;
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
        world = data['world_name'];
        job = data['character_class'];
        level = data['character_level'].toString();
        exp = data['character_exp_rate'] + '%';
      });
    }

    final response5 = await http.get(
      Uri.parse(
          'https://open.api.nexon.com/maplestory/v1/character/stat?ocid=$_ocid'),
      headers: {
        'Accept': 'application/json',
        'x-nxopen-api-key':
            'test_c3c7513e49d03f4c0d14389cf14e274f5504d6b6b0f373662f022b8f07304e4b356397c41c1a3eef638d09601b2f4f18',
      },
    );

    if (response5.statusCode == 200) {
      print("전투력 fetch 성공");
      final Map<String, dynamic> data = json.decode(response5.body);
      setState(() {
        power = data['final_stat'][42]['stat_value'];
        if (power.length < 9) {
          power = power.substring(0, power.length - 4) +
              '만' +
              power.substring(power.length - 4);
        } else {
          power = power.substring(0, power.length - 8) +
              '억' +
              power.substring(power.length - 8, power.length - 4) +
              '만' +
              power.substring(power.length - 4);
        }
        print(power);
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
            builder: (context) => Equip(
                imageList: imageList,
                characterImage: characterImage,
                power: power,
                world: world,
                level: level,
                exp: exp,
                job: job,
                name: name,
                data: data),
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
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/rest.png'),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
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
          ],
        ));
  }
}

const List<String> equipmentData = [
  '반지1',
  '',
  '모자',
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
