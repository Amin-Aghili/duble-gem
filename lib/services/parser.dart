import '../models/dialog_line.dart';

class Parser {
  static List<DialogLine> parse(String text) {
    final lines = text.split('\n');
    return lines.map((line) {
      bool isDone = false;
      String processedLine = line;

      if (line.startsWith('[x]')) {
        isDone = true;
        processedLine = line.substring(4);
      } else if (line.startsWith('[ ]')) {
        processedLine = line.substring(4);
      }

      final parts = processedLine.split(RegExp(r'[:\-]'));
      if (parts.length < 2) {
        return DialogLine(actor: 'ناشناخته', text: line, isDone: isDone);
      }

      final actor = parts[0].trim();
      final dialog = parts.sublist(1).join(':').trim();
      return DialogLine(actor: actor, text: dialog, isDone: isDone);
    }).toList();
  }
}
