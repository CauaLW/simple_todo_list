import 'package:flutter/material.dart';
import 'package:simple_todo_list/adapters/task_adapter.dart';
import 'package:simple_todo_list/atoms/task_atom.dart';
import 'package:simple_todo_list/states/task_state.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();

    taskState.value = const StartTaskState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchTasksAction.value = Object();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListenableBuilder(
        listenable: taskState,
        builder: (context, child) {
          return switch (taskState.value) {
            StartTaskState _ => const SizedBox(),
            FetchingTaskState _ => const Center(child: CircularProgressIndicator()),
            GettedTaskState state => _fetchedTasks(state),
            FailureTaskState state => _failure(state),
          };
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _fetchedTasks(GettedTaskState state) {
    final tasks = state.tasks;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, index) {
        final task = tasks[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/edit', arguments: task);
          },
          leading: Checkbox(
            onChanged: (value) {
              updateTaskAction.value = TaskAdapter.toggleCompleteFromEntity(task);
            },
            value: task.completed,
          ),
          title: Text(
            task.title,
            style: TextStyle(decoration: task.completed ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          trailing: IconButton(
            onPressed: () {
              deleteTaskAction.value = task.id;
            },
            icon: const Icon(Icons.remove_circle),
          ),
        );
      },
    );
  }

  Widget _failure(FailureTaskState state) {
    return Center(
      child: Text(state.message),
    );
  }

  void _createTask() {
    Navigator.of(context).pushNamed('/create');
  }
}
