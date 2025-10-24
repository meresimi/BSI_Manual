import 'package:flutter/material.dart';
import '../data/topics_data.dart';
import '../widgets/topic_tile.dart';
import 'calculator_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();
  String q = '';

  @override
  Widget build(BuildContext context) {
    final list = topics.where((t) {
      final ql = q.toLowerCase();
      if (t.title.toLowerCase().contains(ql)) return true;
      return t.buttons.any((b) => b.toLowerCase().contains(ql));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BSI Manual'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _search,
              onChanged: (v) => setState(() => q = v),
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                final t = list[i];
                final filteredButtons = q.isEmpty
                    ? t.buttons
                    : t.buttons.where((b) => b.toLowerCase().contains(q.toLowerCase())).toList();
                return TopicTile(
                  index: t.id,
                  title: t.title,
                  buttons: filteredButtons,
                  onButtonTap: (label) {
                    if (label.toLowerCase().contains('calculator') || label.toLowerCase().contains('calc')) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CalculatorScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(label)));
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalculatorScreen())),
        label: const Text('Calculator'),
        icon: const Icon(Icons.calculate),
      ),
    );
  }
}
