import 'package:flutter/material.dart';
import 'package:simple_todo_list/dtos/task_dto.dart';
import 'package:simple_todo_list/states/edit_task_state.dart';
import 'package:simple_todo_list/states/task_state.dart';

// Atom
final taskState = ValueNotifier<TaskState>(const StartTaskState());
final updateTaskState = ValueNotifier<UpdateTaskState>(const StartUpdateTaskState());

// Actions
final fetchTasksAction = ValueNotifier(Object());
final createTaskAction = ValueNotifier<TaskDTO>(TaskDTO());
final updateTaskAction = ValueNotifier<TaskDTO>(TaskDTO());
final deleteTaskAction = ValueNotifier(0);
