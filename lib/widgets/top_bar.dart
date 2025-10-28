// widgets/top_bar.dart
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onOpen;
  final double fontSize;
  final ValueChanged<double> onFontSizeChanged;

  const TopBar({
    required this.onOpen,
    required this.fontSize,
    required this.onFontSizeChanged,
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
        const Spacer(),
        const Text('سایز فونت'),
        Slider(value: fontSize, min: 12, max: 30, onChanged: onFontSizeChanged),
      ],
    );
  }
}
