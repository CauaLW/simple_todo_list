import 'package:simple_todo_list/atoms/task_atom.dart';
import 'package:simple_todo_list/services/task_service.dart';
import 'package:simple_todo_list/states/edit_task_state.dart';
import 'package:simple_todo_list/states/task_state.dart';

class TaskReducer {
  final TaskService service;

  TaskReducer(this.service) {
    fetchTasksAction.addListener(_fetchTasks);
    createTaskAction.addListener(_createTask);
    updateTaskAction.addListener(_updateTask);
    deleteTaskAction.addListener(_deleteTask);
  }

  void _fetchTasks() async {
    taskState.value = const FetchingTaskState();
    try {
      final tasks = await service.fetchTasks();
      taskState.value = GettedTaskState(tasks);
    } catch (e) {
      taskState.value = FailureTaskState(e.toString());
    }
  }

  void _createTask() async {
    try {
      final dto = createTaskAction.value;
      await service.createTask(dto);

      updateTaskState.value = const SavedUpdateTaskState();

      _fetchTasks();
    } catch (e) {
      updateTaskState.value = FailureUpdateTaskState(e.toString());
    }
  }

  void _updateTask() async {
    try {
      final dto = updateTaskAction.value;
      await service.updateTask(dto);
      updateTaskState.value = const SavedUpdateTaskState();

      _fetchTasks();
    } catch (e) {
      updateTaskState.value = FailureUpdateTaskState(e.toString());
    }
  }

  void _deleteTask() async {
    final id = deleteTaskAction.value;

    try {
      await service.deleteTask(id);
      _fetchTasks();
    } catch (e) {
      taskState.value = FailureTaskState(e.toString());
    }
  }

  void dispose() {
    fetchTasksAction.removeListener(_fetchTasks);
    createTaskAction.removeListener(_createTask);
    updateTaskAction.removeListener(_updateTask);
    deleteTaskAction.removeListener(_deleteTask);
  }
}
