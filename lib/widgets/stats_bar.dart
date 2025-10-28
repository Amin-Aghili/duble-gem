import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class StatsBar extends StatelessWidget {
  const StatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();
    final selected = provider.selectedActor;

    // اگر بازیگر خاصی انتخاب شده آمار اون، در غیر این صورت آمار کلی
    final total =
        selected == null
            ? provider.totalDialogs
            : provider.actorTotal(selected);
    final done =
        selected == null ? provider.doneDialogs : provider.actorDone(selected);
    final percent =
        selected == null
            ? provider.totalPercent
            : provider.actorPercent(selected);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selected == null ? "کل دیالوگ‌ها" : "آمار برای ${selected}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("کل: $total"),
            Text("گفته‌شده: $done"),
            Text("درصد: ${percent.toStringAsFixed(1)}%"),
          ],
        ),
      ),
    );
  }
}
