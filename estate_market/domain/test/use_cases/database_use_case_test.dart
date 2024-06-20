import 'package:dartz/dartz.dart';
import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/entities/apartment_entity.dart';
import 'package:domain/entities/deposit_entity.dart';
import 'package:domain/entities/garage_entity.dart';
import 'package:domain/entities/residence_entity.dart';
import 'package:domain/entities/terrain_entity.dart';
import 'package:domain/errors/database_errors.dart';
import 'package:domain/use_cases/database_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockDatabaseRepository mockDatabaseRepository;
  late MockAccountRepository mockAccountRepository;
  late MockImageUploadRepository mockImageUploadRepository;
  late DatabaseUseCase databaseUseCase;
  late MockAccountEntity mockAccount;
  late MockAdEntity mockAd;
  late MockDocumentReferenceEntity mockDocumentReference;
  late MockLandmarkEntity mockLandmark;

  setUp(() {
    mockDatabaseRepository = MockDatabaseRepository();
    mockAccountRepository = MockAccountRepository();
    mockImageUploadRepository = MockImageUploadRepository();
    mockAccount = MockAccountEntity();
    mockAd = MockAdEntity();
    mockDocumentReference = MockDocumentReferenceEntity();
    mockLandmark = MockLandmarkEntity();

    databaseUseCase = DatabaseUseCase(
      databaseRepository: mockDatabaseRepository,
      imageUploadRepository: mockImageUploadRepository,
      accountRepository: mockAccountRepository,
    );

    when(mockAccountRepository.currentAccountDocument).thenReturn(mockDocumentReference);
    when(mockDocumentReference.id).thenReturn('document/path');
  });

  group('DatabaseUseCase Tests', () {
    test('insertGarageEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertGarageEntity(
        surface: anyNamed('surface'),
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        parkingType: anyNamed('parkingType'),
        capacity: anyNamed('capacity'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertGarageEntity(
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertGarageEntity(
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      )).called(1);
    });

    test('insertTerrainEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertTerrainEntity(
        surface: anyNamed('surface'),
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        isInBuildUpArea: anyNamed('isInBuildUpArea'),
        landUseCategory: anyNamed('landUseCategory'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertTerrainEntity(
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertTerrainEntity(
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      )).called(1);
    });

    test('insertAdEntity calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertAdEntity(
        title: 'Test Ad',
        category: AdCategory.apartament,
        description: 'Test Description',
        property: mockDocumentReference,
        landmark: mockDocumentReference,
        listingType: ListingType.sale,
        images: ['image1.jpg', 'image2.jpg'],
      );

      // Assert
      verify(mockDatabaseRepository.insertAdEntity(
        title: 'Test Ad',
        category: AdCategory.apartament,
        description: 'Test Description',
        property: mockDocumentReference,
        account: mockDocumentReference,
        landmark: mockDocumentReference,
        listingType: ListingType.sale,
        images: ['image1.jpg', 'image2.jpg'],
      )).called(1);
    });

    test('insertAccountEntity calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertAccountEntity(
        email: 'test@example.com',
        password: 'password123',
        phoneNumber: '1234567890',
        sellerType: SellerType.individual,
      );

      // Assert
      verify(mockDatabaseRepository.insertAccountEntity(
        email: 'test@example.com',
        password: 'password123',
        phoneNumber: '1234567890',
        sellerType: SellerType.individual,
      )).called(1);
    });

    test('updateAd updates an ad entity', () async {
      // Act
      await databaseUseCase.updateAd(
        previousAd: mockAd,
        title: 'Updated Ad',
        category: AdCategory.apartament,
        description: 'Updated Description',
        listingType: ListingType.rent,
        images: ['image3.jpg', 'image4.jpg'],
      );

      // Assert
      verify(mockDatabaseRepository.updateAdEntity(
        previousAd: mockAd,
        title: 'Updated Ad',
        category: AdCategory.apartament,
        description: 'Updated Description',
        listingType: ListingType.rent,
        images: ['image3.jpg', 'image4.jpg'],
      )).called(1);
    });

    test('uploadImages uploads images and returns result', () async {
      // Arrange
      final paths = ['path1.jpg', 'path2.jpg'];
      final uploadedUrls = ['url1.jpg', 'url2.jpg'];
      when(mockImageUploadRepository.uploadImages(paths)).thenAnswer((_) async => Right(uploadedUrls));

      // Act
      final result = await databaseUseCase.uploadImages(paths);

      // Assert
      expect(result, Right(uploadedUrls));
      verify(mockImageUploadRepository.uploadImages(paths)).called(1);
    });

    test('uploadImages handles failure', () async {
      // Arrange
      final paths = ['path1.jpg', 'path2.jpg'];
      final failure = ImageUploadFailed();
      when(mockImageUploadRepository.uploadImages(paths)).thenAnswer((_) async => Left(failure));

      // Act
      final result = await databaseUseCase.uploadImages(paths);

      // Assert
      expect(result, Left(failure));
      verify(mockImageUploadRepository.uploadImages(paths)).called(1);
    });

    test('removeAd calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.removeAd(ad: mockAd);

      // Assert
      verify(mockDatabaseRepository.removeAd(ad: mockAd)).called(1);
    });

    test('insertMessage calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertMessage(
        sender: mockAccount,
        receiver: mockAccount,
        message: 'Hello',
      );

      // Assert
      verify(mockDatabaseRepository.insertMessage(
        sender: mockAccount,
        receiver: mockAccount,
        message: 'Hello',
      )).called(1);
    });

    test('insertGarageEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertGarageEntity(
        surface: anyNamed('surface'),
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        parkingType: anyNamed('parkingType'),
        capacity: anyNamed('capacity'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertGarageEntity(
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertGarageEntity(
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      )).called(1);
    });

    test('insertTerrainEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertTerrainEntity(
        surface: anyNamed('surface'),
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        isInBuildUpArea: anyNamed('isInBuildUpArea'),
        landUseCategory: anyNamed('landUseCategory'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertTerrainEntity(
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertTerrainEntity(
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      )).called(1);
    });

    test('insertAdEntity calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertAdEntity(
        title: 'Test Ad',
        category: AdCategory.apartament,
        description: 'Test Description',
        property: mockDocumentReference,
        landmark: mockDocumentReference,
        listingType: ListingType.sale,
        images: ['image1.jpg', 'image2.jpg'],
      );

      // Assert
      verify(mockDatabaseRepository.insertAdEntity(
        title: 'Test Ad',
        category: AdCategory.apartament,
        description: 'Test Description',
        property: mockDocumentReference,
        account: mockDocumentReference,
        landmark: mockDocumentReference,
        listingType: ListingType.sale,
        images: ['image1.jpg', 'image2.jpg'],
      )).called(1);
    });

    test('insertAccountEntity calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertAccountEntity(
        email: 'test@example.com',
        password: 'password123',
        phoneNumber: '1234567890',
        sellerType: SellerType.individual,
      );

      // Assert
      verify(mockDatabaseRepository.insertAccountEntity(
        email: 'test@example.com',
        password: 'password123',
        phoneNumber: '1234567890',
        sellerType: SellerType.individual,
      )).called(1);
    });

    test('updateAd updates an ad entity', () async {
      // Act
      await databaseUseCase.updateAd(
        previousAd: mockAd,
        title: 'Updated Ad',
        category: AdCategory.apartament,
        description: 'Updated Description',
        listingType: ListingType.rent,
        images: ['image3.jpg', 'image4.jpg'],
      );

      // Assert
      verify(mockDatabaseRepository.updateAdEntity(
        previousAd: mockAd,
        title: 'Updated Ad',
        category: AdCategory.apartament,
        description: 'Updated Description',
        listingType: ListingType.rent,
        images: ['image3.jpg', 'image4.jpg'],
      )).called(1);
    });

    test('uploadImages uploads images and returns result', () async {
      // Arrange
      final paths = ['path1.jpg', 'path2.jpg'];
      final uploadedUrls = ['url1.jpg', 'url2.jpg'];
      when(mockImageUploadRepository.uploadImages(paths)).thenAnswer((_) async => Right(uploadedUrls));

      // Act
      final result = await databaseUseCase.uploadImages(paths);

      // Assert
      expect(result, Right(uploadedUrls));
      verify(mockImageUploadRepository.uploadImages(paths)).called(1);
    });

    test('uploadImages handles failure', () async {
      // Arrange
      final paths = ['path1.jpg', 'path2.jpg'];
      final failure = ImageUploadFailed();
      when(mockImageUploadRepository.uploadImages(paths)).thenAnswer((_) async => Left(failure));

      // Act
      final result = await databaseUseCase.uploadImages(paths);

      // Assert
      expect(result, Left(failure));
      verify(mockImageUploadRepository.uploadImages(paths)).called(1);
    });

    test('removeAd calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.removeAd(ad: mockAd);

      // Assert
      verify(mockDatabaseRepository.removeAd(ad: mockAd)).called(1);
    });

    test('insertMessage calls the correct method with correct parameters', () async {
      // Act
      await databaseUseCase.insertMessage(
        sender: mockAccount,
        receiver: mockAccount,
        message: 'Hello',
      );

      // Assert
      verify(mockDatabaseRepository.insertMessage(
        sender: mockAccount,
        receiver: mockAccount,
        message: 'Hello',
      )).called(1);
    });

    test('insertApartmentEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertApartmentEntity(
        surface: anyNamed('surface'),
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        partitioning: anyNamed('partitioning'),
        floor: anyNamed('floor'),
        numberOfRooms: anyNamed('numberOfRooms'),
        numberOfBathrooms: anyNamed('numberOfBathrooms'),
        furnishingLevel: anyNamed('furnishingLevel'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertApartmentEntity(
        surface: 80.0,
        price: 100000.0,
        isNegotiable: true,
        constructionYear: 2015,
        partitioning: Partitioning.selfContained,
        floor: 2,
        numberOfRooms: 3,
        numberOfBathrooms: 2,
        furnishingLevel: FurnishingLevel.furnished,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertApartmentEntity(
        surface: 80.0,
        price: 100000.0,
        isNegotiable: true,
        constructionYear: 2015,
        partitioning: Partitioning.selfContained,
        floor: 2,
        numberOfRooms: 3,
        numberOfBathrooms: 2,
        furnishingLevel: FurnishingLevel.furnished,
      )).called(1);
    });

    test('updateApartmentEntity updates an apartment entity', () async {
      // Act
      await databaseUseCase.updateApartmentEntity(
        previousProperty: mockDocumentReference,
        surface: 80.0,
        price: 100000.0,
        isNegotiable: true,
        constructionYear: 2015,
        partitioning: Partitioning.selfContained,
        floor: 2,
        numberOfRooms: 3,
        numberOfBathrooms: 2,
        furnishingLevel: FurnishingLevel.furnished,
      );

      // Assert
      verify(mockDatabaseRepository.updateApartmentEntity(
        previousProperty: mockDocumentReference,
        surface: 80.0,
        price: 100000.0,
        isNegotiable: true,
        constructionYear: 2015,
        partitioning: Partitioning.selfContained,
        floor: 2,
        numberOfRooms: 3,
        numberOfBathrooms: 2,
        furnishingLevel: FurnishingLevel.furnished,
      )).called(1);
    });

    test('insertHouseEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertHouseEntity(
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        insideSurface: anyNamed('insideSurface'),
        outsideSurface: anyNamed('outsideSurface'),
        numberOfFloors: anyNamed('numberOfFloors'),
        numberOfRooms: anyNamed('numberOfRooms'),
        numberOfBathrooms: anyNamed('numberOfBathrooms'),
        furnishingLevel: anyNamed('furnishingLevel'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertHouseEntity(
        price: 200000.0,
        isNegotiable: true,
        constructionYear: 2010,
        insideSurface: 150.0,
        outsideSurface: 100.0,
        numberOfFloors: 2,
        numberOfRooms: 5,
        numberOfBathrooms: 3,
        furnishingLevel: FurnishingLevel.furnished,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertHouseEntity(
        price: 200000.0,
        isNegotiable: true,
        constructionYear: 2010,
        insideSurface: 150.0,
        outsideSurface: 100.0,
        numberOfFloors: 2,
        numberOfRooms: 5,
        numberOfBathrooms: 3,
        furnishingLevel: FurnishingLevel.furnished,
      )).called(1);
    });

    test('updateHouseEntity updates a house entity', () async {
      // Act
      await databaseUseCase.updateHouseEntity(
        previousProperty: mockDocumentReference,
        price: 200000.0,
        isNegotiable: true,
        constructionYear: 2010,
        insideSurface: 150.0,
        outsideSurface: 100.0,
        numberOfFloors: 2,
        numberOfRooms: 5,
        numberOfBathrooms: 3,
        furnishingLevel: FurnishingLevel.furnished,
      );

      // Assert
      verify(mockDatabaseRepository.updateHouseEntity(
        previousProperty: mockDocumentReference,
        price: 200000.0,
        isNegotiable: true,
        constructionYear: 2010,
        insideSurface: 150.0,
        outsideSurface: 100.0,
        numberOfFloors: 2,
        numberOfRooms: 5,
        numberOfBathrooms: 3,
        furnishingLevel: FurnishingLevel.furnished,
      )).called(1);
    });

    test('insertDepositEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertDepositEntity(
        price: anyNamed('price'),
        isNegotiable: anyNamed('isNegotiable'),
        constructionYear: anyNamed('constructionYear'),
        height: anyNamed('height'),
        usableSurface: anyNamed('usableSurface'),
        administrativeSurface: anyNamed('administrativeSurface'),
        depositType: anyNamed('depositType'),
        parkingSpaces: anyNamed('parkingSpaces'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertDepositEntity(
        price: 80000.0,
        isNegotiable: true,
        constructionYear: 2018,
        height: 10.0,
        usableSurface: 500.0,
        administrativeSurface: 100.0,
        depositType: DepositType.deposit,
        parkingSpaces: 10,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertDepositEntity(
        price: 80000.0,
        isNegotiable: true,
        constructionYear: 2018,
        height: 10.0,
        usableSurface: 500.0,
        administrativeSurface: 100.0,
        depositType: DepositType.deposit,
        parkingSpaces: 10,
      )).called(1);
    });

    test('updateDepositEntity updates a deposit entity', () async {
      // Act
      await databaseUseCase.updateDepositEntity(
        previousProperty: mockDocumentReference,
        price: 80000.0,
        isNegotiable: true,
        constructionYear: 2018,
        height: 10.0,
        usableSurface: 500.0,
        administrativeSurface: 100.0,
        depositType: DepositType.deposit,
        parkingSpaces: 10,
      );

      // Assert
      verify(mockDatabaseRepository.updateDepositEntity(
        previousProperty: mockDocumentReference,
        price: 80000.0,
        isNegotiable: true,
        constructionYear: 2018,
        height: 10.0,
        usableSurface: 500.0,
        administrativeSurface: 100.0,
        depositType: DepositType.deposit,
        parkingSpaces: 10,
      )).called(1);
    });

    test('insertLandmarkEntity returns a document reference', () async {
      // Arrange
      when(mockDatabaseRepository.insertLandmarkEntity(
        landmark: anyNamed('landmark'),
      )).thenAnswer((_) async => mockDocumentReference);

      // Act
      final result = await databaseUseCase.insertLandmarkEntity(
        landmark: mockLandmark,
      );

      // Assert
      expect(result, mockDocumentReference);
      verify(mockDatabaseRepository.insertLandmarkEntity(
        landmark: mockLandmark,
      )).called(1);
    });

    test('updateLandmark updates a landmark entity', () async {
      // Act
      await databaseUseCase.updateLandmark(
        previousLandmark: mockLandmark,
        landmark: mockLandmark,
      );

      // Assert
      verify(mockDatabaseRepository.updateLandmarkEntity(
        previousLandmark: mockLandmark,
        landmark: mockLandmark,
      )).called(1);
    });

    test('updateGarageEntity updates a garage entity', () async {
      // Act
      await databaseUseCase.updateGarageEntity(
        previousProperty: mockDocumentReference,
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      );

      // Assert
      verify(mockDatabaseRepository.updateGarageEntity(
        previousProperty: mockDocumentReference,
        surface: 100.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2020,
        parkingType: ParkingType.interiorParking,
        capacity: 2,
      )).called(1);
    });

    test('updateTerrainEntity updates a terrain entity', () async {
      // Act
      await databaseUseCase.updateTerrainEntity(
        previousProperty: mockDocumentReference,
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      );

      // Assert
      verify(mockDatabaseRepository.updateTerrainEntity(
        previousProperty: mockDocumentReference,
        surface: 500.0,
        price: 50000.0,
        isNegotiable: true,
        constructionYear: 2000,
        isInBuildUpArea: true,
        landUseCategory: LandUseCategories.agriculture,
      )).called(1);
    });
  });
}
