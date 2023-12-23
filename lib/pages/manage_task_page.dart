import 'package:flutter/material.dart';
import 'package:simple_todo_list/adapters/task_adapter.dart';
import 'package:simple_todo_list/atoms/task_atom.dart';
import 'package:simple_todo_list/dtos/task_dto.dart';
import 'package:simple_todo_list/entities/task_entity.dart';
import 'package:simple_todo_list/states/edit_task_state.dart';
import 'package:simple_todo_list/widgets/switch_input.dart';
import 'package:simple_todo_list/widgets/text_input.dart';

class ManageTask extends StatefulWidget {
  final TaskEntity? entity;
  const ManageTask({super.key, this.entity});

  @override
  State<ManageTask> createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
  late TaskDTO dto;

  bool get isEdit => widget.entity != null;

  @override
  void initState() {
    super.initState();

    if (widget.entity != null) {
      dto = TaskAdapter.entityToDTO(widget.entity!);
    } else {
      dto = TaskDTO();
    }

    updateTaskState.value = const StartUpdateTaskState();
    updateTaskState.addListener(_listener);
  }

  _listener() {
    setState(() {});
    return switch (updateTaskState.value) {
      StartUpdateTaskState state => state,
      SavedUpdateTaskState _ => Navigator.of(context).pop(),
      LoadingUpdateTaskState state => state,
      FailureUpdateTaskState state => _showSnackError(state),
    };
  }

  @override
  void dispose() {
    updateTaskState.removeListener(_listener);
    super.dispose();
  }

  void _showSnackError(FailureUpdateTaskState state) {
    final snackBar = SnackBar(
      content: Text(
        state.message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _save() {
    if (!dto.isValid()) {
      _showSnackError(const FailureUpdateTaskState('Invalid fields'));
      return;
    }

    if (isEdit) {
      updateTaskAction.value = dto.copy();
    } else {
      createTaskAction.value = dto.copy();
    }
  }

  void _clear() {
    setState(() {
      dto = TaskDTO(id: dto.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = updateTaskState.value;

    final enabled = state is! LoadingUpdateTaskState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextInput(
              key: Key('title:$enabled${dto.hashCode}'),
              enabled: enabled,
              initialValue: dto.title,
              hint: 'Title',
              validator: dto.titleValidate,
              onChanged: (value) => dto.title = value,
            ),
            const SizedBox(height: 5),
            SwitchInput(
              key: Key('completed:$enabled${dto.hashCode}'),
              label: 'Done',
              enabled: enabled,
              initialValue: dto.completed,
              onChanged: (value) {
                dto.completed = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: enabled ? _save : null,
                  child: const Text('Save'),
                ),
                OutlinedButton(
                  onPressed: enabled ? _clear : null,
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
