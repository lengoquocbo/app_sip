import 'package:flutter/material.dart';

class NumberPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(8),
      crossAxisCount: 2,
      children: List.generate(9, (index) {
        return Center(child: Text('${index + 1}', style: TextStyle(fontSize: 32)));
      })..addAll([
          Center(child: Text('*', style: TextStyle(fontSize: 32))),
          Center(child: Text('0', style: TextStyle(fontSize: 32))),
          Center(child: Text('#', style: TextStyle(fontSize: 32))),
        ]),
    );
  }
}
