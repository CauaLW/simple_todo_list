import 'package:simple_todo_list/dtos/task_dto.dart';
import 'package:simple_todo_list/entities/task_entity.dart';

class TaskAdapter {
  TaskAdapter._();

  static Map<String, Object?> toMap(TaskDTO dto) {
    Map<String, Object?> map = {
      'title': dto.title,
      'completed': dto.completed ? 1 : 0,
    };

    if (dto.id != null) {
      map['id'] = dto.id;
    }

    return map;
  }

  static TaskEntity fromMap(Map<String, dynamic> map) {
    return TaskEntity(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
    );
  }

  static TaskDTO entityToDTO(TaskEntity entity) {
    return TaskDTO(id: entity.id, title: entity.title, completed: entity.completed);
  }

  static TaskDTO toggleCompleteFromEntity(TaskEntity entity) {
    return TaskDTO(
      id: entity.id,
      title: entity.title,
      completed: !entity.completed,
    );
  }
}
