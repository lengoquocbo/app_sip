import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> demoHistory = [
    {'name': 'Nguyễn Văn A', 'time': 'Hôm qua, 14:30'},
    {'name': 'Trần Thị B', 'time': 'Hôm nay, 09:15'},
    {'name': 'Lê Quốc Cường', 'time': 'Hôm nay, 11:45'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lịch sử cuộc gọi')),
      body: ListView.builder(
        itemCount: demoHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.history),
            title: Text(demoHistory[index]['name']!),
            subtitle: Text(demoHistory[index]['time']!),
          );
        },
      ),
    );
  }
}
