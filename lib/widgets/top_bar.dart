// widgets/top_bar.dart
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onOpen;

  const TopBar({
    required this.onOpen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: onOpen,
          icon: const Icon(Icons.folder_open),
          label: const Text('باز کردن فایل'),
        ),
      ],
    );
  }
}
