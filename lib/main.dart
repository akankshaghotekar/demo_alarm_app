import 'package:demo_alarm_app/qr_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AlarmDemo());
  }
}

class AlarmDemo extends StatefulWidget {
  const AlarmDemo({super.key});

  @override
  State<AlarmDemo> createState() => _AlarmDemoState();
}

class _AlarmDemoState extends State<AlarmDemo> {
  static const channel = MethodChannel('alarm_channel');

  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarm Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await channel.invokeMethod('scheduleAlarm');
              },
              child: const Text('Start Alarm'),
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            //   onPressed: () async {
            //     await channel.invokeMethod('stopAlarm');
            //   },
            //   child: const Text('Stop Alarm'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => QrScanScreen()),
                );
              },
              child: const Text('Open QR Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
