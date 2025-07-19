import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  final List<String> demoContacts = [
    'Nguyễn Văn A',
    'Trần Thị B',
    'Lê Quốc Cường',
    'Phạm Văn D',
    'Ngô Thanh E',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gọi điện')),
      body: ListView.builder(
        itemCount: demoContacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(demoContacts[index]),
            trailing: Icon(Icons.call),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gọi tới ${demoContacts[index]}...')),
              );
            },
          );
        },
      ),
    );
  }
}
