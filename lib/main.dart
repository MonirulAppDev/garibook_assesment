import 'app/bootstrap.dart';

/// Single entry point for every flavor; the flavor is picked at build time
/// with `flutter run --flavor dev|prod`.
Future<void> main() => bootstrap();
