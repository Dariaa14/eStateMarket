import 'package:dartz/dartz.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/filter_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockFilterRepository mockFilterRepository;
  late FilterUseCase filterUseCase;
  late MockAdEntity mockAd;
  late List<AdEntity> ads;

  setUp(() {
    mockFilterRepository = MockFilterRepository();
    mockAd = MockAdEntity();
    ads = [mockAd, mockAd];
    when(mockFilterRepository.streamAds()).thenAnswer((_) => Stream.value(ads));

    filterUseCase = FilterUseCase(filterRepository: mockFilterRepository);
  });

  tearDown(() {
    filterUseCase.dispose();
  });

  group('FilterUseCase Tests', () {
    test('adsStream emits ads from repository', () async {
      // Assert
      await expectLater(filterUseCase.adsStream, emits(ads));
    });

    test('setCurrentCategory calls setCurrentCategory on repository', () {
      // Act
      filterUseCase.setCurrentCategory(AdCategory.apartament);

      // Assert
      verify(mockFilterRepository.setCurrentCategory(AdCategory.apartament)).called(1);
    });

    test('setCurrentListingType calls setCurrentListingType on repository', () {
      // Act
      filterUseCase.setCurrentListingType(ListingType.sale);

      // Assert
      verify(mockFilterRepository.setCurrentListingType(ListingType.sale)).called(1);
    });

    test('setPriceRange calls setPriceRange on repository', () {
      // Act
      final priceRange = Tuple2<double?, double?>(100.0, 500.0);
      filterUseCase.setPriceRange(priceRange);

      // Assert
      verify(mockFilterRepository.setPriceRange(priceRange)).called(1);
    });

    test('setSurfaceRange calls setSurfaceRange on repository', () {
      // Act
      final surfaceRange = Tuple2<double?, double?>(50.0, 200.0);
      filterUseCase.setSurfaceRange(surfaceRange);

      // Assert
      verify(mockFilterRepository.setSurfaceRange(surfaceRange)).called(1);
    });

    test('setSearchQuery calls setSearchQuery on repository', () {
      // Act
      filterUseCase.setSearchQuery('query');

      // Assert
      verify(mockFilterRepository.setSearchQuery('query')).called(1);
    });

    test('dispose closes the ads controller', () {
      // Act
      filterUseCase.dispose();

      // Assert
      expect(filterUseCase.isControllerClosed(), true);
    });
  });
}
