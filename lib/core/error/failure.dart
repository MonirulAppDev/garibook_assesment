/// Base type for every expected, recoverable error that crosses a layer
/// boundary (data -> domain -> presentation).
///
/// Each feature declares its own `sealed` subtype (e.g. `LocationFailure`)
/// so presentation code can switch exhaustively without string parsing.
abstract base class Failure {
  const Failure(this.message);

  /// Developer-facing description. UI copy is derived from the failure
  /// *type*, never from this string.
  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

/// Fallback for programming errors that escaped the typed mapping.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, [this.error, this.stackTrace]);

  final Object? error;
  final StackTrace? stackTrace;
}
