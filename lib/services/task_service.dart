import 'package:simple_todo_list/adapters/task_adapter.dart';
import 'package:simple_todo_list/dtos/task_dto.dart';
import 'package:simple_todo_list/entities/task_entity.dart';
import 'package:sqflite/sqflite.dart';

const String taskTable = 'Task';

// TODO: implement services
class TaskService {
  final Database db;

  TaskService(this.db);

  Future<List<TaskEntity>> fetchTasks() async {
    final List<Map<String, Object?>> rawResults = await db.query(taskTable, orderBy: 'id');
    final List<TaskEntity> tasks = List.generate(rawResults.length, (index) {
      final Map<String, Object?> map = rawResults[index];
      return TaskAdapter.fromMap(map);
    });
    print(rawResults);
    return tasks;
  }

  Future<void> createTask(TaskDTO dto) async {
    await db.insert(taskTable, TaskAdapter.toMap(dto));
  }

  Future<void> updateTask(TaskDTO dto) async {
    await db.update(
      taskTable,
      TaskAdapter.toMap(dto),
      where: 'id = ?',
      whereArgs: [dto.id!],
    );
  }

  Future<void> deleteTask(int id) async {
    await db.delete(
      taskTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
