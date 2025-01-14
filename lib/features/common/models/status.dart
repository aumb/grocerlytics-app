sealed class Status<T> {
  const Status();
}

class InitialStatus<T> extends Status<T> {
  const InitialStatus();
}

class LoadingStatus<T> extends Status<T> {
  const LoadingStatus();
}

class LoadedStatus<T> extends Status<T> {
  const LoadedStatus();
}

class ErrorStatus<T> extends Status<T> {
  const ErrorStatus(this.error);

  final Object error;
}

class EmptyStatus<T> extends Status<T> {
  const EmptyStatus();
}

extension StatusX on Status {
  bool get isLoading => this is LoadingStatus;
  bool get hasError => this is ErrorStatus;
}
