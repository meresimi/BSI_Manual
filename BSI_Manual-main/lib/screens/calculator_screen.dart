import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final Map<String, TextEditingController> _ctrl = {};
  double total = 0.0;

  void _recalculate() {
    double sum = 0.0;
    _ctrl.forEach((k, c) {
      final v = double.tryParse(c.text.trim()) ?? 0.0;
      sum += v;
    });
    setState(() => total = sum);
  }

  @override
  Widget build(BuildContext context) {
    const schema = <Map<String, String>>[
      {'name': 'searchInput', 'label': 'searchInput'}
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ...schema.map((f) {
              final name = f['name']!;
              final label = f['label'] ?? name;
              _ctrl.putIfAbsent(name, () => TextEditingController());
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: _ctrl[name],
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: label,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (v) => _recalculate(),
                ),
              );
            }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(total.toStringAsFixed(2), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
