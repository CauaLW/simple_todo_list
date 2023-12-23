sealed class UpdateTaskState {
  const UpdateTaskState();
}

class StartUpdateTaskState extends UpdateTaskState {
  const StartUpdateTaskState();
}

class SavedUpdateTaskState extends UpdateTaskState {
  const SavedUpdateTaskState();
}

class LoadingUpdateTaskState extends UpdateTaskState {
  const LoadingUpdateTaskState();
}

class FailureUpdateTaskState extends UpdateTaskState {
  final String message;
  const FailureUpdateTaskState(this.message);
}
