import 'package:domain/repositories/permission_repository.dart';
import 'package:domain/use_cases/location_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockPermissionRepository mockPermissionRepository;
  late MockPositionRepository mockPositionRepository;
  late LocationUseCase locationUseCase;
  late MockPositionEntity mockPositionEntity;

  setUp(() {
    mockPermissionRepository = MockPermissionRepository();
    mockPositionRepository = MockPositionRepository();
    mockPositionEntity = MockPositionEntity();

    locationUseCase = LocationUseCase(
      permissionRepository: mockPermissionRepository,
      positionRepository: mockPositionRepository,
    );

    when(mockPermissionRepository.permissionStream(PermissionType.locationWhenInUse))
        .thenAnswer((_) => Stream.value(AccessStatus.granted));
    when(mockPermissionRepository.isGranted(PermissionType.locationWhenInUse)).thenReturn(true);
    when(mockPermissionRepository.isLocationEnabled).thenReturn(true);
    when(mockPermissionRepository.locationStatusStream).thenAnswer((_) => Stream.value(true));
    when(mockPositionRepository.positionStream).thenAnswer((_) => Stream.value(mockPositionEntity));
    when(mockPositionRepository.position).thenReturn(mockPositionEntity);
  });

  group('LocationUseCase Tests', () {
    test('initialize listens to permission stream and updates location permission status', () async {
      // Arrange
      when(mockPermissionRepository.permissionStream(PermissionType.locationWhenInUse))
          .thenAnswer((_) => Stream.value(AccessStatus.granted));

      // Act
      locationUseCase.initialize();
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockPositionRepository.setLivePosition()).called(1);
      expectLater(locationUseCase.locationPermissionStream, emits(true));
    });

    test('positionStream emits position from repository', () async {
      // Assert
      await expectLater(locationUseCase.positionStream, emits(mockPositionEntity));
    });

    test('locationStatusStream emits location status from repository', () async {
      // Assert
      await expectLater(locationUseCase.locationStatusStream, emits(true));
    });

    test('hasPosition returns correct value', () {
      // Act
      final result = locationUseCase.hasPosition;

      // Assert
      expect(result, true);
    });

    test('hasLocationPermission returns correct value', () {
      // Act
      final result = locationUseCase.hasLocationPermission;

      // Assert
      expect(result, true);
    });

    test('isLocationEnabled returns correct value', () {
      // Act
      final result = locationUseCase.isLocationEnabled;

      // Assert
      expect(result, true);
    });

    test('updatePermissionsStatus calls updatePermissionsStatus on repository', () async {
      // Act
      await locationUseCase.updatePermissionsStatus();

      // Assert
      verify(mockPermissionRepository.updatePermissionsStatus()).called(1);
    });

    test('askLocationPermission calls askPermission on repository and returns result', () async {
      // Arrange
      when(mockPermissionRepository.isGranted(PermissionType.locationWhenInUse)).thenAnswer((_) => false);
      when(mockPermissionRepository.askPermission(PermissionType.locationWhenInUse)).thenAnswer((_) async => true);

      // Act
      final result = await locationUseCase.askLocationPermission();

      // Assert
      expect(result, true);
      verify(mockPermissionRepository.askPermission(PermissionType.locationWhenInUse)).called(1);
    });

    test('askLocationPermission calls askPermission on repository and permission is already allowed', () async {
      // Arrange
      when(mockPermissionRepository.isGranted(PermissionType.locationWhenInUse)).thenAnswer((_) => true);

      // Act
      final result = await locationUseCase.askLocationPermission();

      // Assert
      expect(result, true);
      verifyNever(mockPermissionRepository.askPermission(PermissionType.locationWhenInUse));
    });

    test('openLocationService calls openLocationService on repository and returns result', () async {
      // Arrange
      when(mockPermissionRepository.openLocationService()).thenAnswer((_) async => true);

      // Act
      final result = await locationUseCase.openLocationService();

      // Assert
      expect(result, true);
      verify(mockPermissionRepository.openLocationService()).called(1);
    });
  });
}
