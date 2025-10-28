import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class DialogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();
    final dialogs = provider.dialogs;

    return ListView.builder(
      itemCount: dialogs.length,
      itemBuilder: (context, i) {
        final line = dialogs[i];
        final selected = provider.selectedActor;

        // اگر بازیگری انتخاب نشده، همه پررنگ باشن
        final isHighlighted = selected == null || selected == line.actor;

        return GestureDetector(
          onDoubleTap: () => provider.toggleDialog(line),
          child: Opacity(
            opacity: isHighlighted ? 1.0 : 0.3,
            child: ListTile(
              leading: Checkbox(
                value: line.isDone,
                onChanged: (_) => provider.toggleDialog(line),
              ),
              title: Text(
                "${line.actor}: ${line.text}",
                style: TextStyle(
                  fontSize: provider.fontSize,
                  decoration:
                      line.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
