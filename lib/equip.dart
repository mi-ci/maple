import 'package:flutter/material.dart';

class Equip extends StatelessWidget {
  final List<String> imageList;
  const Equip({Key? key, required this.imageList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Equipment Grid'),
        ),
        body: EquipmentGrid(imageList: imageList),
      ),
    );
  }
}

class EquipmentGrid extends StatelessWidget {
  final List<String> imageList;

  const EquipmentGrid({Key? key, required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          );
        }),
      ),
    );
  }
}

class EquipmentSlot extends StatelessWidget {
  final String label;
  final Color color;
  final String imageUrl;

  const EquipmentSlot(
      {Key? key,
      required this.label,
      required this.color,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
