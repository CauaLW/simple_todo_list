import 'package:simple_todo_list/dtos/dto.dart';
import 'package:simple_todo_list/dtos/task_validate_mixin.dart';

class TaskDTO extends DTO with TaskValidate {
  int? id;
  String title;
  bool completed;

  TaskDTO({
    this.id,
    this.title = '',
    this.completed = false,
  });

  TaskDTO copy() {
    return TaskDTO(
      id: id,
      title: title,
      completed: completed,
    );
  }

  @override
  void validate() {
    titleValidate(title);
  }
}
