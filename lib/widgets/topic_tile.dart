import 'package:flutter/material.dart';

class TopicTile extends StatelessWidget {
  final int index;
  final String title;
  final List<String> buttons;
  final void Function(String) onButtonTap;
  const TopicTile({super.key, required this.index, required this.title, required this.buttons, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 28,
              child: Text('$index.', textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(title)),
          ],
        ),
        children: buttons.map((b) => Padding(
          padding: const EdgeInsets.only(left: 36, bottom: 8, right: 12),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => onButtonTap(b),
              child: Align(alignment: Alignment.centerLeft, child: Text(b)),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
