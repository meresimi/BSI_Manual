\
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/rate_service.dart';
import '../widgets/search_bar.dart';

class RatesPage extends StatefulWidget {
  const RatesPage({super.key});
  @override
  State<RatesPage> createState() => _RatesPageState();
}

class _RatesPageState extends State<RatesPage> {
  final _controller = TextEditingController();
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final rateService = Provider.of<RateService>(context);
    final items = _q.isEmpty ? rateService.items : rateService.search(_q);

    return Scaffold(
      appBar: AppBar(title: const Text('Rates')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BsiSearchBar(hint: 'Search rates, code, or category...', controller: _controller, onChanged: (v) => setState(() => _q = v)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final r = items[i];
                  return Card(
                    child: ListTile(
                      title: Text('${r.code} — ${r.name}'),
                      subtitle: Text('${r.unit} • ${r.category}'),
                      trailing: Text(r.amount.toStringAsFixed(2)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
