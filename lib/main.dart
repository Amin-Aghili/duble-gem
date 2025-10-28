import 'package:duble_gem/models/dialog_line.dart';
import 'package:duble_gem/services/parser.dart';
import 'package:duble_gem/utils/theme.dart';
import 'package:duble_gem/widgets/actore_selector.dart';
import 'package:duble_gem/widgets/dialog_list.dart';
import 'package:duble_gem/widgets/stats_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(const DubbingApp());
}

class DubbingApp extends StatefulWidget {
  const DubbingApp({super.key});

  @override
  State<DubbingApp> createState() => _DubbingAppState();
}

class _DubbingAppState extends State<DubbingApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dubbing Assistant",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: ChangeNotifierProvider(
        create: (_) => DialogProvider(),
        child: HomePage(
          onThemeChanged: () {
            setState(() {
              themeMode =
                  themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
            });
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final VoidCallback onThemeChanged;
  const HomePage({super.key, required this.onThemeChanged});

  Future<void> pickFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      context.read<DialogProvider>().loadFromText(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DialogProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("دستیار دوبله"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onThemeChanged,
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => pickFile(context),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:
            provider.dialogs.isEmpty
                ? const Center(
                  child: Text("لطفاً یک فایل متنی دوبله انتخاب کنید"),
                )
                : Column(
                  children: [
                    ActorSelector(),
                    const StatsBar(),
                    Expanded(child: DialogList()),
                  ],
                ),
      ),
    );
  }
}

class DialogProvider extends ChangeNotifier {
  List<DialogLine> dialogs = [];
  String? selectedActor;

  void loadFromText(String text) {
    dialogs = Parser.parse(text);
    selectedActor = null;
    notifyListeners();
  }

  void toggleDialog(DialogLine line) {
    line.isDone = !line.isDone;
    notifyListeners();
  }

  void selectActor(String? actor) {
    selectedActor = actor;
    notifyListeners();
  }

  // --- آمار کلی ---
  int get totalDialogs => dialogs.length;
  int get doneDialogs => dialogs.where((d) => d.isDone).length;
  double get totalPercent =>
      totalDialogs == 0 ? 0 : (doneDialogs / totalDialogs) * 100;

  // --- آمار بر اساس بازیگر ---
  int actorTotal(String actor) => dialogs.where((d) => d.actor == actor).length;

  int actorDone(String actor) =>
      dialogs.where((d) => d.actor == actor && d.isDone).length;

  double actorPercent(String actor) {
    final total = actorTotal(actor);
    if (total == 0) return 0;
    return (actorDone(actor) / total) * 100;
  }
}
