\
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/rate_service.dart';
import '../services/calculator_service.dart';
import '../widgets/search_bar.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _searchCtl = TextEditingController();
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final rateService = Provider.of<RateService>(context);
    final calc = Provider.of<CalculatorService>(context);
    final results = _q.isEmpty ? rateService.items : rateService.search(_q);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BsiSearchBar(hint: 'Find a service to add...', controller: _searchCtl, onChanged: (v) => setState(() => _q = v)),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                children: [
                  // Left: search results
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Results', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (_, i) {
                              final r = results[i];
                              return Card(
                                child: ListTile(
                                  title: Text('${r.code} — ${r.name}'),
                                  subtitle: Text('${r.unit} • ${r.category}'),
                                  trailing: TextButton.icon(
                                    onPressed: () => calc.add(r),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Right: cart
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Items', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: calc.cart.length,
                            itemBuilder: (_, i) {
                              final c = calc.cart[i];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text('${c.rate.code} — ${c.rate.name}')),
                                      SizedBox(
                                        width: 120,
                                        child: Row(
                                          children: [
                                            IconButton(onPressed: () => calc.setQuantity(c.rate.code, c.quantity - 1), icon: const Icon(Icons.remove)),
                                            Text('${c.quantity}'),
                                            IconButton(onPressed: () => calc.setQuantity(c.rate.code, c.quantity + 1), icon: const Icon(Icons.add)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(c.total.toStringAsFixed(2)),
                                      IconButton(onPressed: () => calc.remove(c.rate.code), icon: const Icon(Icons.delete_outline)),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: Theme.of(context).textTheme.titleLarge),
                            Text(calc.total.toStringAsFixed(2), style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Notes', border: OutlineInputBorder()),
                          minLines: 1, maxLines: 3,
                          onChanged: calc.setNote,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ElevatedButton.icon(onPressed: () { /* TODO: export/share */ }, icon: const Icon(Icons.share), label: const Text('Share Quote')),
                            const SizedBox(width: 12),
                            OutlinedButton.icon(onPressed: calc.clear, icon: const Icon(Icons.clear), label: const Text('Clear')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
