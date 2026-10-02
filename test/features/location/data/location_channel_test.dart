import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garibook_assesment/core/result/result.dart';
import 'package:garibook_assesment/features/location/data/datasources/location_channel_contract.dart';
import 'package:garibook_assesment/features/location/data/datasources/location_platform_data_source.dart';
import 'package:garibook_assesment/features/location/data/repositories/location_repository_impl.dart';
import 'package:garibook_assesment/features/location/domain/entities/location_permission_status.dart';
import 'package:garibook_assesment/features/location/domain/entities/location_request_options.dart';
import 'package:garibook_assesment/features/location/domain/failures/location_failure.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const methodChannel = MethodChannel('test/location');
  const eventChannelName = 'test/location/updates';
  const eventChannel = EventChannel(eventChannelName);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  late LocationRepositoryImpl repository;

  setUp(() {
    repository = LocationRepositoryImpl(
      MethodChannelLocationDataSource.withChannels(methodChannel, eventChannel),
    );
  });

  tearDown(() {
    messenger.setMockMethodCallHandler(methodChannel, null);
    messenger.setMockStreamHandler(eventChannel, null);
  });

  void mockMethod(Future<Object?>? Function(MethodCall call) handler) =>
      messenger.setMockMethodCallHandler(methodChannel, handler);

  group('permission', () {
    test('parses every permission value', () async {
      const cases = {
        LocationChannelContract.permissionGranted:
            LocationPermissionStatus.granted,
        LocationChannelContract.permissionGrantedApproximate:
            LocationPermissionStatus.grantedApproximate,
        LocationChannelContract.permissionDenied:
            LocationPermissionStatus.denied,
        LocationChannelContract.permissionDeniedForever:
            LocationPermissionStatus.deniedForever,
      };
      for (final entry in cases.entries) {
        mockMethod((_) async => entry.key);
        final result = await repository.checkPermission();
        expect(result.valueOrNull, entry.value);
      }
    });
  });

  group('error mapping', () {
    const codes = <String, Type>{
      LocationChannelContract.errPermissionDenied: LocationPermissionDenied,
      LocationChannelContract.errPermissionDeniedForever:
          LocationPermissionDeniedForever,
      LocationChannelContract.errServicesDisabled: LocationServiceDisabled,
      LocationChannelContract.errTimeout: LocationTimeout,
      LocationChannelContract.errNoActivity: LocationUnavailable,
      LocationChannelContract.errRequestInProgress: LocationUnavailable,
      LocationChannelContract.errPlayServicesUnavailable: LocationUnavailable,
      'SOMETHING_NEW': LocationUnknownFailure,
    };

    for (final entry in codes.entries) {
      test('${entry.key} -> ${entry.value}', () async {
        mockMethod((_) async => throw PlatformException(code: entry.key));
        final result =
            await repository.getCurrentLocation(const LocationRequestOptions());
        expect(result, isA<Err<Object?>>());
        expect((result as Err).failure.runtimeType, entry.value);
      });
    }

    test('no native implementation -> LocationNotSupported', () async {
      // No mock handler registered => MissingPluginException.
      final result = await repository.checkPermission();
      expect((result as Err).failure, isA<LocationNotSupported>());
    });
  });

  test('getCurrentLocation decodes the fix and sends arguments', () async {
    MethodCall? received;
    mockMethod((call) async {
      received = call;
      return {
        LocationChannelContract.keyLatitude: 23.81,
        LocationChannelContract.keyLongitude: 90.41,
        LocationChannelContract.keyAccuracy: 5.0,
        LocationChannelContract.keyTimestampMs: 1700000000000,
      };
    });

    final result = await repository.getCurrentLocation(
      const LocationRequestOptions(timeout: Duration(seconds: 7)),
    );

    final fix = result.valueOrNull!;
    expect(fix.position.latitude, 23.81);
    expect(fix.position.longitude, 90.41);
    expect(fix.accuracyMeters, 5.0);
    expect(received!.method, LocationChannelContract.getCurrentLocation);
    expect(
      (received!.arguments as Map)[LocationChannelContract.argTimeoutMs],
      7000,
    );
  });

  test('stream maps errors to failures and cancel reaches native', () async {
    var cancelled = false;
    messenger.setMockStreamHandler(
      eventChannel,
      MockStreamHandler.inline(
        onListen: (_, sink) {
          sink.success({
            LocationChannelContract.keyLatitude: 1.0,
            LocationChannelContract.keyLongitude: 2.0,
          });
          sink.error(code: LocationChannelContract.errServicesDisabled);
        },
        onCancel: (_) => cancelled = true,
      ),
    );

    final events = <Result<Object?>>[];
    final sub = repository
        .watchLocation(const LocationRequestOptions())
        .listen(events.add);
    await pumpEventQueue();

    expect(events, hasLength(2));
    expect(events[0].isOk, isTrue);
    expect((events[1] as Err).failure, isA<LocationServiceDisabled>());

    await sub.cancel();
    await pumpEventQueue();
    expect(cancelled, isTrue);
  });
}
