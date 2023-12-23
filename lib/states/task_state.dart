import 'package:simple_todo_list/entities/task_entity.dart';

sealed class TaskState {
  const TaskState();
}

class StartTaskState extends TaskState {
  const StartTaskState();
}

class FetchingTaskState extends TaskState {
  const FetchingTaskState();
}

class GettedTaskState extends TaskState {
  final List<TaskEntity> tasks;
  const GettedTaskState(this.tasks);
}

class FailureTaskState extends TaskState {
  final String message;
  const FailureTaskState(this.message);
}
