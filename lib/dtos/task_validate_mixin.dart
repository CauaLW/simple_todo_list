import 'package:simple_todo_list/exceptions/validate_exception.dart';

mixin class TaskValidate {
  void titleValidate(String title) {
    if (title.isEmpty) {
      throw 'The title can\'t be empty'.asException();
    }
  }
}
