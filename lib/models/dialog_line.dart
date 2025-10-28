class DialogLine {
  final String actor;
  final String text;
  bool isDone;

  DialogLine({required this.actor, required this.text, this.isDone = false});

  String toFileFormat() {
    return "${isDone ? '[x]' : '[ ]'} $actor: $text";
  }
}
