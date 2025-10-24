\
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/rate_service.dart';
import '../services/calculator_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rates = Provider.of<RateService>(context);
    final calc = Provider.of<CalculatorService>(context);

    final categories = rates.categories();
    final itemsPerCat = { for (var c in categories) c : rates.items.where((r) => r.category == c).length };
    final topCosting = rates.items.toList()..sort((a,b) => b.amount.compareTo(a.amount));

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Wrap(
              spacing: 12, runSpacing: 12,
              children: [
                _StatCard(title: 'Categories', value: '${categories.length}'),
                _StatCard(title: 'Rates', value: '${rates.items.length}'),
                _StatCard(title: 'Cart Items', value: '${calc.cart.length}'),
                _StatCard(title: 'Cart Total', value: calc.total.toStringAsFixed(2)),
              ],
            ),
            const SizedBox(height: 16),
            Text('Items per Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...itemsPerCat.entries.map((e) => ListTile(
              leading: const Icon(Icons.folder),
              title: Text(e.key),
              trailing: Text('${e.value}'),
            )),
            const Divider(),
            Text('Top Costing Services', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...topCosting.take(5).map((r) => ListTile(
              leading: const Icon(Icons.trending_up),
              title: Text('${r.code} — ${r.name}'),
              trailing: Text(r.amount.toStringAsFixed(2)),
            )),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
