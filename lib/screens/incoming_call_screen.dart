import 'dart:async';
import 'package:flutter/material.dart';

class IncomingCallScreen extends StatefulWidget {
  final String caller;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const IncomingCallScreen({
    Key? key,
    required this.caller,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  Timer? _timer;
  int _seconds = 0;
  bool _callStarted = false;

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _startCallTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _seconds++);
    });
  }

  void _handleAccept() {
    widget.onAccept();
    if (!_callStarted) {
      _startCallTimer();
      setState(() => _callStarted = true);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phone_in_talk, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 24),
            const Text(
              'Cuộc gọi đến',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              widget.caller,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            if (_callStarted) ...[
              const SizedBox(height: 16),
              Text(
                _formatDuration(_seconds),
                style: const TextStyle(fontSize: 22, color: Colors.greenAccent, fontWeight: FontWeight.bold),
              ),
            ],
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'reject',
                  backgroundColor: Colors.red,
                  onPressed: widget.onReject,
                  child: const Icon(Icons.call_end, color: Colors.white, size: 32),
                ),
                FloatingActionButton(
                  heroTag: 'accept',
                  backgroundColor: Colors.green,
                  onPressed: _handleAccept,
                  child: const Icon(Icons.call, color: Colors.white, size: 32),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
