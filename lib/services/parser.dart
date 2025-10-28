import '../models/dialog_line.dart';

class Parser {
  static List<DialogLine> parse(String text) {
    final lines = text.split('\n');
    return lines.map((line) {
      final parts = line.split(RegExp(r'[:\-]'));
      if (parts.length < 2) return DialogLine(actor: 'ناشناخته', text: line);
      final actor = parts[0].trim();
      final dialog = parts.sublist(1).join(':').trim();
      return DialogLine(actor: actor, text: dialog);
    }).toList();
  }
}
