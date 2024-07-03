import 'package:flutter/material.dart';

class Equip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Equipment Grid'),
        ),
        body: EquipmentGrid(),
      ),
    );
  }
}

class EquipmentGrid extends StatelessWidget {
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
          if (equipmentData[index].isEmpty) {
            return Container(); // Empty container for empty slots
          }
          return EquipmentSlot(
            label: equipmentData[index],
            color: equipmentColors[index],
          );
        }),
      ),
    );
  }
}

class EquipmentSlot extends StatelessWidget {
  final String label;
  final Color color;

  const EquipmentSlot({Key? key, required this.label, required this.color})
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
        child: Image.asset("assets/hat.png"),
        // child: Text(
        //   label,
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 10,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
      ),
    );
  }
}

const List<String> equipmentData = [
  'RING',
  '',
  'CAP',
  '',
  'EMBLEM',
  'RING',
  'PENDANT',
  'FORE HEAD',
  '',
  'BADGE',
  'RING',
  'PENDANT',
  'EYE ACC',
  'EAR ACC',
  'MEDAL',
  'RING',
  'WEAPON',
  'CLOTHES',
  'SHOULDER',
  'SUB WEAPON',
  'POKET',
  'BELT',
  'PANTS',
  'GLOVES',
  'CAPE',
  'SHOES',
  '',
  'ANDROID',
  '',
  'HEART',
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
