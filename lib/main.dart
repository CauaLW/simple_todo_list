import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simple_todo_list/entities/task_entity.dart';
import 'package:simple_todo_list/pages/manage_task_page.dart';
import 'package:simple_todo_list/pages/tasks_page.dart';
import 'package:simple_todo_list/reducers/task_reducer.dart';
import 'package:simple_todo_list/services/task_service.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'simple_todo.db');

  final Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the task table
      await db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, title TEXT, completed BOOL default true)');
    },
  );

  runApp(RootWidget(db: db));
}

class RootWidget extends StatefulWidget {
  final Database db;
  const RootWidget({super.key, required this.db});

  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  late final TaskService taskService;
  late final TaskReducer taskReducer;

  @override
  void initState() {
    super.initState();
    taskService = TaskService(widget.db);
    taskReducer = TaskReducer(taskService);
  }

  @override
  void dispose() {
    taskReducer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MainApp();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple TODO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const TasksPage(),
        '/create': (_) => const ManageTask(),
        '/edit': (context) {
          final entity =
              ModalRoute.of(context)?.settings.arguments as TaskEntity?;
          return ManageTask(entity: entity);
        }
      },
    );
  }
}
