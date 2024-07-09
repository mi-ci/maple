import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class Equip extends StatelessWidget {
  final List<String> imageList;
  final String characterImage;
  final String power;
  final String world;
  final String level;
  final String exp;
  final String job;
  final String name;
  final Map data;

  const Equip({
    Key? key,
    required this.imageList,
    required this.characterImage,
    required this.power,
    required this.world,
    required this.level,
    required this.exp,
    required this.job,
    required this.name,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Center(
          child: Text(
            name,
            style: TextStyle(fontFamily: 'maplebold'),
          ),
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the character image at the top
            Container(
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: FadeInLeft(
                    from: 60,
                    delay: Duration(milliseconds: 500),
                    duration: Duration(seconds: 1),
                    child: Text(
                      '$world \n$job \n레벨 : $level \n경험치 : $exp',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'maplelight'),
                    ),
                  )),
                  SizedBox(width: 10),
                  Image.network(
                    characterImage,
                    height: 100, // Adjust height as needed
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                      width: 10), // Add some spacing between image and text
                  Expanded(
                      child: FadeInRight(
                    from: 60,
                    delay: Duration(milliseconds: 500),
                    duration: Duration(seconds: 1),
                    child: Text(
                      '전투력 \n $power',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'maplebold'),
                    ),
                  )),
                ],
              ),
            ),
            // Display the equipment grid
            Expanded(
              child: FadeInUp(
                from: 60,
                delay: Duration(milliseconds: 500),
                duration: Duration(seconds: 1),
                child: EquipmentGrid(imageList: imageList, data: data),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentGrid extends StatelessWidget {
  final List<String> imageList;
  final Map data;
  const EquipmentGrid({Key? key, required this.imageList, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(58.0),
      child: GridView.count(
        crossAxisCount: 5,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(equipmentData.length, (index) {
          String imageUrl = imageList[index];
          if (equipmentData[index].isEmpty) {
            return Container(); // Empty container for empty slots
          }
          return EquipmentSlot(
              label: equipmentData[index],
              color: equipmentColors[index],
              imageUrl: imageUrl,
              data: data);
        }),
      ),
    );
  }
}

class EquipmentSlot extends StatelessWidget {
  final String label;
  final Color color;
  final String imageUrl;
  final Map data;

  const EquipmentSlot(
      {Key? key,
      required this.label,
      required this.color,
      required this.imageUrl,
      required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEquipmentPreview(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black26),
        ),
        child: Center(
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                )
              : Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }

  void _showEquipmentPreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: imageUrl.isNotEmpty
              ? ItemDetailCard(imageUrl: imageUrl, data: data)
              : Text('No preview available for $label'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
const Map<String, String> optionData = {
  "str": "STR",
  "dex": "DEX",
  "int": "INT",
  "luk": "LUK",
  "attack_power": "공격력",
  "magic_power": "마력",
  "max_hp": "최대 HP",
  "max_mp": "최대 MP",
  "armor": "방어력",
  "speed": "이동속도",
  "jump": "점프력",
  "boss_damage": "보스 몬스터 공격시 데미지",
  "ignore_monster_armor": "몬스터 방어율 무시",
  "all_stat": "올스탯",
  "damage": "데미지",
  "equipment_level_decrease": "착용 레벨 감소",
  "max_hp_rate": "최대 HP",
  "max_mp_rate": "최대 MP",
};

const List<Color> equipmentColors = [
  Colors.brown,
  Colors.transparent,
  Colors.grey,
  Colors.transparent,
  Colors.blue,
  Colors.brown,
  Colors.brown,
  Colors.grey,
  Colors.transparent,
  Colors.blue,
  Colors.brown,
  Colors.brown,
  Colors.grey,
  Colors.grey,
  Colors.blue,
  Colors.brown,
  Colors.brown,
  Colors.grey,
  Colors.grey,
  Colors.blue,
  Colors.brown,
  Colors.brown,
  Colors.grey,
  Colors.grey,
  Colors.grey,
  Colors.grey,
  Colors.transparent,
  Colors.grey,
  Colors.transparent,
  Colors.grey,
];

List<Color> colors = [Colors.white, Colors.green, Colors.blue, Colors.orange];

///////////////////////////////////////////////////

class ItemDetailCard extends StatelessWidget {
  final String imageUrl;
  final Map data;
  ItemDetailCard({required this.imageUrl, required this.data});

  @override
  Widget build(BuildContext context) {
    Map? itemData;
    for (Map i in data['item_equipment']) {
      if (i['item_icon'] == imageUrl) {
        itemData = i;
        break;
      }
    }

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        border: Border.all(color: Colors.grey.shade700),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with stars and item name
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 4.0, // Space between stars in a row
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < 15; i++) ...[
                      Icon(
                        Icons.star,
                        color: i < int.parse(itemData!['starforce'])
                            ? Colors.yellow
                            : Colors.grey,
                        size: 8,
                      ),
                      if (i == 4 || i == 9) SizedBox(width: 4),
                    ]
                  ],
                ),
                SizedBox(height: 8.0), // Space between the rows of stars
                Wrap(
                  spacing: 4.0,
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 15; i < 25; i++) ...[
                      Icon(
                        Icons.star,
                        color: i < int.parse(itemData!['starforce'])
                            ? Colors.yellow
                            : Colors.grey,
                        size: 8,
                      ),
                      if (i == 19) SizedBox(width: 4),
                    ]
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: itemData!['scroll_upgrade'] != '0'
                ? Text(
                    '${itemData!['item_name']} (+${itemData!['scroll_upgrade']})',
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  )
                : Text(
                    '${itemData!['item_name']}',
                    style: TextStyle(color: Colors.orange, fontSize: 12),
                  ),
          ),

          // SizedBox(height: 8),
          if (itemData['potential_option_grade'] == '레전드리')
            Center(
              child: Text('(${itemData!['potential_option_grade']})',
                  style: TextStyle(color: Colors.greenAccent)),
            ),
          if (itemData['potential_option_grade'] == '유니크')
            Center(
              child: Text('(${itemData!['potential_option_grade']})',
                  style: TextStyle(color: Colors.yellow)),
            ),
          if (itemData['potential_option_grade'] == '에픽')
            Center(
              child: Text('(${itemData!['potential_option_grade']})',
                  style: TextStyle(color: Colors.purple)),
            ),
          if (itemData['potential_option_grade'] == '레어')
            Center(
              child: Text('(${itemData!['potential_option_grade']})',
                  style: TextStyle(color: Colors.blueAccent)),
            ),
          // SizedBox(height: 8),

          // Item icon and required level
          Row(
            children: [
              Image.network(
                imageUrl,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'REQ LEV : ${itemData['item_base_option']['base_equipment_level']}',
                      style: TextStyle(color: Colors.yellow, fontSize: 12)),
                  Text('장비 분류 : ${itemData['item_equipment_part']}',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          ...itemData['item_total_option']
              .entries
              .where((entry) => entry.value.toString() != "0")
              .toList()
              .map((entry) => buildStatRow(
                  optionData[entry.key]!, entry.value.toString(),
                  additional: buildAdditionalString(entry.key, itemData!),
                  color: Colors.lightBlueAccent)),

          if (itemData['potential_option_1'] != null)
            Divider(color: Colors.grey),
          // Potential options
          if (itemData['potential_option_1'] != null)
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.greenAccent, size: 12),
                SizedBox(width: 4),
                Text('잠재 옵션',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
              ],
            ),
          if (itemData['potential_option_1'] != null) ...[
            if (itemData['potential_option_1']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['potential_option_1'].toString().split(':')[0],
                  itemData['potential_option_1']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['potential_option_1'].toString().split(':')[0],
                  itemData['potential_option_1'].toString().split(':')[1],
                  color: Colors.white),
          ],
          if (itemData['potential_option_2'] != null) ...[
            if (itemData['potential_option_2']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['potential_option_2'].toString().split(':')[0],
                  itemData['potential_option_2']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['potential_option_2'].toString().split(':')[0],
                  itemData['potential_option_2'].toString().split(':')[1],
                  color: Colors.white),
          ],
          if (itemData['potential_option_3'] != null) ...[
            if (itemData['potential_option_3']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['potential_option_3'].toString().split(':')[0],
                  itemData['potential_option_3']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['potential_option_3'].toString().split(':')[0],
                  itemData['potential_option_3'].toString().split(':')[1],
                  color: Colors.white),
          ],
          if (itemData['additional_potential_option_1'] != null)
            Divider(color: Colors.grey),
          if (itemData['additional_potential_option_1'] != null)
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.greenAccent, size: 12),
                SizedBox(width: 4),
                Text('에디셔널 옵션',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
              ],
            ),
          if (itemData['additional_potential_option_1'] != null) ...[
            if (itemData['additional_potential_option_1']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['additional_potential_option_1']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_1']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['additional_potential_option_1']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_1']
                      .toString()
                      .split(':')[1],
                  color: Colors.white),
          ],
          if (itemData['additional_potential_option_2'] != null) ...[
            if (itemData['additional_potential_option_2']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['additional_potential_option_2']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_2']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['additional_potential_option_2']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_2']
                      .toString()
                      .split(':')[1],
                  color: Colors.white),
          ],
          if (itemData['additional_potential_option_3'] != null) ...[
            if (itemData['additional_potential_option_3']
                .toString()
                .split(':')[0]
                .contains("재사용"))
              buildStatRow(
                  itemData['additional_potential_option_3']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_3']
                      .toString()
                      .split(':')[1]
                      .substring(0, 4),
                  color: Colors.white)
            else
              buildStatRow(
                  itemData['additional_potential_option_3']
                      .toString()
                      .split(':')[0],
                  itemData['additional_potential_option_3']
                      .toString()
                      .split(':')[1],
                  color: Colors.white),
          ],
        ],
      ),
    );
  }

  String buildAdditionalString(String key, Map itemData) {
    List<String> additionalValues = [
      itemData['item_base_option'][key]?.toString() ?? '0',
      itemData['item_add_option'][key]?.toString() ?? '0',
      itemData['item_etc_option'][key]?.toString() ?? '0',
      itemData['item_starforce_option'][key]?.toString() ?? '0'
    ];

    return '(' +
        additionalValues
            .where((value) => value != '0' && value != null)
            .join('+') +
        ')';
  }

  Widget buildStatRow(String label, String value,
      {String additional = '', Color color = Colors.white}) {
    List<String> additionalValues = additional
        .replaceAll('(', '')
        .replaceAll(')', '')
        .split('+')
        .where((value) => value.isNotEmpty)
        .toList();
    ;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text('$label : ',
              style: TextStyle(color: Colors.white, fontSize: 10)),
          Text(value, style: TextStyle(color: color, fontSize: 10)),
          if (additional.isNotEmpty)
            RichText(
              text: TextSpan(
                children: List.generate(additionalValues.length, (index) {
                  return TextSpan(
                    text: (index == 0 ? ' (' : '+') +
                        additionalValues[index] +
                        (index == additionalValues.length - 1 ? ')' : ''),
                    style: TextStyle(
                      color: colors[index % colors.length],
                      fontSize: 10,
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}
