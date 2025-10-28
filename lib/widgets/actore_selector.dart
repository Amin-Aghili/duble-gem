// widgets/actor_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart'; // برای DialogProvider

class ActorSelector extends StatelessWidget {
  const ActorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();
    // ساخت لیست یکتا و مرتب از بازیگران
    final actors =
        provider.dialogs.map((e) => e.actor).toSet().toList()..sort();

    // اگر هیچ بازیگری وجود نداشت، یک ویجت ساده برگردان
    if (actors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'فایلی بارگذاری نشده یا دیالوگی موجود نیست',
          textDirection: TextDirection.rtl,
        ),
      );
    }

    // ساخت آیتم‌ها: آیتم اول = همه (null)
    final List<DropdownMenuItem<String?>> items = [
      const DropdownMenuItem<String?>(value: null, child: Text('همه بازیگران')),
      ...actors.map(
        (a) => DropdownMenuItem<String?>(
          value: a,
          child: Text(a, textDirection: TextDirection.rtl),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
      child: Row(
        children: [
          DropdownButton<String?>(
            value: provider.selectedActor, // این مقدار از نوع String? است
            items: items,
            hint: const Text('انتخاب بازیگر'),
            onChanged: (val) {
              provider.selectActor(val);
            },
            itemHeight: 48,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            isDense: true,
          ),
          const Spacer(),
          const Text('سایز فونت'),
          Expanded(
            child: Slider(
              value: provider.fontSize,
              min: 12,
              max: 38,
              onChanged: (val) {
                provider.changeFontSize(val);
              },
            ),
          ),
        ],
      ),
    );
  }
}
