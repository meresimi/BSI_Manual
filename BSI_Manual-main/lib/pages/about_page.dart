\
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('BSI Manual', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('A Flutter replica of the original Cordova/VoltBuilder app.'),
            SizedBox(height: 12),
            Text('Contact: sales@meresimi.com.sb • Tanuli, Honiara • (677) 7633214'),
          ],
        ),
      ),
    );
  }
}
