import 'package:flutter/material.dart';
import 'package:voip24h_sdk_mobile/voip24h_sdk_mobile.dart';
import 'package:voip24h_sdk_mobile/models/SipConfiguration.dart';
import 'screens/dial_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIP App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SIPLoginScreen(),
    );
  }
}

class SIPLoginScreen extends StatefulWidget {
  @override
  _SIPLoginScreenState createState() => _SIPLoginScreenState();
}

class _SIPLoginScreenState extends State<SIPLoginScreen> {
  final TextEditingController _sipController = TextEditingController();
  String _status = '';
  bool _isLoading = false;

  Future<void> _login() async {
    final input = _sipController.text.trim();

    if (input != '1111') {
      setState(() {
        _status = '❌ SIP không hợp lệ. Chỉ cho phép 1111';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _status = '🔄 Đang đăng nhập SIP...';
    });

    try {
      final sipConfig = SipConfiguration(
        userName: '1111',
        password: '1111', // thay bằng mật khẩu SIP thật
        domain: '192.168.1.100', // thay bằng IP/domain SIP server thật
        port: 5060,
        displayName: 'User 1111',
        transport: 'UDP',
        stun: '', // để trống nếu không dùng NAT
      );

      await Voip24hSDK.callModule.initSipModule(sipConfig);

      // Nếu thành công → chuyển sang giao diện chính
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNavPage()),
      );
    } catch (e) {
      setState(() {
        _status = '⚠️ Lỗi đăng nhập SIP: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng nhập SIP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sipController,
              decoration: InputDecoration(
                labelText: 'Nhập số SIP (ví dụ: 1111)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Đăng nhập'),
                  ),
            SizedBox(height: 20),
            Text(_status, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DialScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dialpad),
            label: 'Gọi điện',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch sử',
          ),
        ],
      ),
    );
  }
}
