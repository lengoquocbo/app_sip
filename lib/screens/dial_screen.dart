import 'package:flutter/material.dart';

class DialScreen extends StatefulWidget {
  @override
  _DialScreenState createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {
  String dialedNumber = '';
  final double buttonSize = 50; // Thay đổi giá trị này để chỉnh kích thước nút

  void _addDigit(String digit) {
    setState(() {
      dialedNumber += digit;
    });
  }

  void _deleteDigit() {
    setState(() {
      if (dialedNumber.isNotEmpty) {
        dialedNumber = dialedNumber.substring(0, dialedNumber.length - 1);
      }
    });
  }

  void _makeCall() {
    if (dialedNumber.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Gọi điện'),
          content: Text('Bạn có muốn gọi đến số $dialedNumber?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _startCall();
              },
              child: const Text('Gọi'),
            ),
          ],
        ),
      );
    }
  }

  void _startCall() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đang gọi $dialedNumber...')),
    );
  }

  Widget _buildButton(String digit, {String? letters}) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                digit,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (letters != null && letters.isNotEmpty)
                Text(
                  letters,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dialPad = [
      {'digit': '1', 'letters': ''},
      {'digit': '2', 'letters': 'ABC'},
      {'digit': '3', 'letters': 'DEF'},
      {'digit': '4', 'letters': 'GHI'},
      {'digit': '5', 'letters': 'JKL'},
      {'digit': '6', 'letters': 'MNO'},
      {'digit': '7', 'letters': 'PQRS'},
      {'digit': '8', 'letters': 'TUV'},
      {'digit': '9', 'letters': 'WXYZ'},
      {'digit': '*', 'letters': ''},
      {'digit': '0', 'letters': '+'},
      {'digit': '#', 'letters': ''},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Gọi điện'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            dialedNumber.isEmpty ? 'Nhập số điện thoại' : dialedNumber,
            style: TextStyle(
              fontSize: dialedNumber.isEmpty ? 18 : 28,
              color: dialedNumber.isEmpty ? Colors.grey : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          if (dialedNumber.isNotEmpty)
            Text(
              'Số điện thoại',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dialPad.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final item = dialPad[index];
                return _buildButton(
                  item['digit']!,
                  letters: item['letters']!.isNotEmpty ? item['letters'] : null,
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: _deleteDigit,
                icon: const Icon(Icons.backspace_outlined),
                iconSize: 32,
              ),
              GestureDetector(
                onTap: dialedNumber.isNotEmpty ? _makeCall : null,
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: dialedNumber.isNotEmpty ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.white, size: 32),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.contacts),
                          title: const Text('Danh bạ'),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.history),
                          title: const Text('Lịch sử cuộc gọi'),
                          onTap: () => Navigator.pop(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.voicemail),
                          title: const Text('Thư thoại'),
                          onTap: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.more_horiz),
                iconSize: 32,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}