import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class StatisticsDialog extends StatefulWidget {
  const StatisticsDialog({super.key});

  @override
  _StatisticsDialogState createState() => _StatisticsDialogState();
}

class _StatisticsDialogState extends State<StatisticsDialog> {
  final _rateController = TextEditingController();
  double _totalPayment = 0;

  @override
  void initState() {
    super.initState();
    _rateController.addListener(_calculatePayment);
  }

  @override
  void dispose() {
    _rateController.dispose();
    super.dispose();
  }

  void _calculatePayment() {
    final provider = context.read<DialogProvider>();
    final rate = double.tryParse(_rateController.text) ?? 0;
    setState(() {
      _totalPayment = rate * provider.doneDialogs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();
    final actors = provider.dialogs.map((e) => e.actor).toSet().toList()..sort();
    final rate = double.tryParse(_rateController.text) ?? 0;

    return AlertDialog(
      title: const Text('آمار'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('تعداد کل دیالوگ‌ها: ${provider.totalDialogs}'),
            Text('تعداد دیالوگ‌های خوانده شده: ${provider.doneDialogs}'),
            Text('درصد پیشرفت: ${provider.totalPercent.toStringAsFixed(2)}%'),
            const Divider(),
            ...actors.map((actor) {
              final actorPayment = rate * provider.actorDone(actor);
              return Text(
                  '$actor: ${provider.actorDone(actor)} / ${provider.actorTotal(actor)} - پرداختی: ${actorPayment.toStringAsFixed(2)} تومان');
            }),
            const Divider(),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'نرخ هر دیالوگ',
                suffixText: 'تومان',
              ),
            ),
            const SizedBox(height: 16),
            Text('مبلغ کل پرداختی: ${_totalPayment.toStringAsFixed(2)} تومان'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('بستن'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
