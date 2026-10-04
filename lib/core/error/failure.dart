abstract base class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, [this.error, this.stackTrace]);

  final Object? error;
  final StackTrace? stackTrace;
}
