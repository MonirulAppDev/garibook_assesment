enum RoutingErrorType {
  noRoute,
  network,
  timeout,
  rateLimited,
  server,
  badResponse,
  cancelled,
}

/// Data-layer routing error; mapped to `RoutingFailure` by the repository.
final class RoutingException implements Exception {
  const RoutingException(this.type, [this.message]);

  final RoutingErrorType type;
  final String? message;

  @override
  String toString() => 'RoutingException($type, $message)';
}
