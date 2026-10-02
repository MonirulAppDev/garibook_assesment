import '../result/result.dart';

/// A single application action (Single Responsibility).
abstract interface class UseCase<T, P> {
  Future<Result<T>> call(P params);
}

/// A use case that produces a continuous stream of results.
abstract interface class StreamUseCase<T, P> {
  Stream<Result<T>> call(P params);
}

/// Marker for use cases that take no input.
final class NoParams {
  const NoParams();
}
