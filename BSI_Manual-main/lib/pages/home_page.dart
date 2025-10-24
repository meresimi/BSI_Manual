\
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _NavTile('Calculator', Icons.calculate, '/calculator', 'Compute BSI service fees'),
      _NavTile('Rates', Icons.list_alt, '/rates', 'Browse fees & services'),
      _NavTile('Dashboard', Icons.dashboard, '/dashboard', 'Quick insights and lens views'),
      _NavTile('About', Icons.info, '/about', 'App info and contact'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('BSI Manual')),
      body: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        padding: const EdgeInsets.all(16),
        children: tiles.map((t) => _HomeCard(tile: t)).toList(),
      ),
    );
  }
}

class _NavTile {
  final String title;
  final IconData icon;
  final String route;
  final String subtitle;
  _NavTile(this.title, this.icon, this.route, this.subtitle);
}

class _HomeCard extends StatelessWidget {
  final _NavTile tile;
  const _HomeCard({required this.tile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, tile.route),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tile.icon, size: 48),
              const SizedBox(height: 12),
              Text(tile.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(tile.subtitle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
