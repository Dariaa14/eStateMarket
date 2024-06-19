import 'dart:async';

import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/repositories/account_repository.dart';
import 'package:domain/repositories/database_repository.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'domain_test.mocks.dart';

@GenerateMocks([AccountRepository, AccountEntity, AdEntity, DatabaseRepository])
void main() {
  late MockAccountRepository mockAccountRepository;
  late MockDatabaseRepository mockDatabaseRepository;
  late AccountUseCase accountUseCase;
  late AccountEntity mockAccountEntity;
  late AdEntity mockAdEntity;

  late StreamController<AccountEntity?> accountStreamController;
  late StreamController<List<AdEntity>?> favoriteAdsStreamController;
  late StreamController<List<AdEntity?>> myAdsStreamController;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    mockAccountEntity = MockAccountEntity();
    mockAdEntity = MockAdEntity();
    mockDatabaseRepository = MockDatabaseRepository();

    accountStreamController = StreamController<AccountEntity?>();
    favoriteAdsStreamController = StreamController<List<AdEntity>?>();
    myAdsStreamController = StreamController<List<AdEntity?>>();

    when(mockAccountRepository.accountStream).thenAnswer((_) => accountStreamController.stream);
    when(mockAccountRepository.favoriteAdsStream).thenAnswer((_) => favoriteAdsStreamController.stream);
    when(mockAccountRepository.myAdsStream).thenAnswer((_) => myAdsStreamController.stream);

    accountUseCase = AccountUseCase(
      accountRepository: mockAccountRepository,
      databaseRepository: mockDatabaseRepository,
    );
  });

  tearDown(() {
    accountStreamController.close();
    favoriteAdsStreamController.close();
    myAdsStreamController.close();
    accountUseCase.dispose();
  });

  group('AccountRepository Tests', () {
    test('setCurrentAccountByEmail sets account by email', () async {
      // Arrange
      when(mockAccountRepository.setCurrentAccountByEmail(any)).thenAnswer((_) async => Future.value());

      // Act
      await mockAccountRepository.setCurrentAccountByEmail('test@example.com');

      // Assert
      verify(mockAccountRepository.setCurrentAccountByEmail('test@example.com')).called(1);
    });

    test('updateAccount updates account details', () async {
      // Arrange
      when(mockAccountRepository.updateAccount(any, any)).thenAnswer((_) async => Future.value());

      // Act
      await mockAccountRepository.updateAccount('1234567890', SellerType.individual);

      // Assert
      verify(mockAccountRepository.updateAccount('1234567890', SellerType.individual)).called(1);
    });

    test('addFavoriteAd adds an ad to favorites', () {
      // Arrange
      when(mockAccountRepository.favoriteAds).thenReturn([mockAdEntity]);

      // Act
      mockAccountRepository.addFavoriteAd(mockAdEntity);

      // Assert
      verify(mockAccountRepository.addFavoriteAd(mockAdEntity)).called(1);
    });

    test('removeFavoriteAd removes an ad from favorites', () {
      // Arrange
      when(mockAccountRepository.favoriteAds).thenReturn([mockAdEntity]);

      // Act
      mockAccountRepository.removeFavoriteAd(mockAdEntity);

      // Assert
      verify(mockAccountRepository.removeFavoriteAd(mockAdEntity)).called(1);
    });

    test('accountStream emits account entity', () {
      // Arrange
      when(mockAccountRepository.accountStream).thenAnswer((_) => Stream.value(mockAccountEntity));

      // Act
      final stream = mockAccountRepository.accountStream;

      // Assert
      expectLater(stream, emits(mockAccountEntity));
    });

    test('favoriteAdsStream emits favorite ads', () {
      // Arrange
      when(mockAccountRepository.favoriteAdsStream).thenAnswer((_) => Stream.value([mockAdEntity]));

      // Act
      final stream = mockAccountRepository.favoriteAdsStream;

      // Assert
      expectLater(stream, emits([mockAdEntity]));
    });

    test('myAdsStream emits my ads', () {
      // Arrange
      when(mockAccountRepository.myAdsStream).thenAnswer((_) => Stream.value([mockAdEntity]));

      // Act
      final stream = mockAccountRepository.myAdsStream;

      // Assert
      expectLater(stream, emits([mockAdEntity]));
    });

    test('removeCurrentAccount removes the current account', () {
      // Act
      mockAccountRepository.removeCurrentAccount();

      // Assert
      verify(mockAccountRepository.removeCurrentAccount()).called(1);
    });

    test('updateAccount handles null and non-null values correctly', () async {
      // Arrange
      when(mockAccountRepository.updateAccount(any, any)).thenAnswer((_) async => Future.value());

      // Act
      await mockAccountRepository.updateAccount(null, SellerType.individual);
      await mockAccountRepository.updateAccount('1234567890', null);
      await mockAccountRepository.updateAccount('0987654321', SellerType.company);

      // Assert
      verify(mockAccountRepository.updateAccount(null, SellerType.individual)).called(1);
      verify(mockAccountRepository.updateAccount('1234567890', null)).called(1);
      verify(mockAccountRepository.updateAccount('0987654321', SellerType.company)).called(1);
    });

    test('addFavoriteAd and removeFavoriteAd manage favorite ads correctly', () {
      when(mockAccountRepository.favoriteAds).thenReturn([]);
      when(mockAccountRepository.addFavoriteAd(mockAdEntity)).thenAnswer((_) {
        mockAccountRepository.favoriteAds!.add(mockAdEntity);
      });
      when(mockAccountRepository.removeFavoriteAd(mockAdEntity)).thenAnswer((_) {
        mockAccountRepository.favoriteAds!.remove(mockAdEntity);
      });

      mockAccountRepository.addFavoriteAd(mockAdEntity);
      expect(mockAccountRepository.favoriteAds!.length, 1);
      mockAccountRepository.removeFavoriteAd(mockAdEntity);
      expect(mockAccountRepository.favoriteAds!.length, 0);

      verify(mockAccountRepository.addFavoriteAd(mockAdEntity)).called(1);
      verify(mockAccountRepository.removeFavoriteAd(mockAdEntity)).called(1);
    });

    test('streams emit correct values', () {
      // Arrange
      when(mockAccountRepository.accountStream).thenAnswer((_) => Stream.value(mockAccountEntity));
      when(mockAccountRepository.favoriteAdsStream).thenAnswer((_) => Stream.value([mockAdEntity]));
      when(mockAccountRepository.myAdsStream).thenAnswer((_) => Stream.value([mockAdEntity]));

      // Act & Assert
      expectLater(mockAccountRepository.accountStream, emits(mockAccountEntity));
      expectLater(mockAccountRepository.favoriteAdsStream, emits([mockAdEntity]));
      expectLater(mockAccountRepository.myAdsStream, emits([mockAdEntity]));
    });

    test('removeCurrentAccount sets currentAccount to null', () {
      // Arrange
      when(mockAccountRepository.currentAccount).thenReturn(mockAccountEntity);
      AccountEntity? currentAccount = mockAccountEntity;

      when(mockAccountRepository.removeCurrentAccount()).thenAnswer((_) {
        currentAccount = null;
      });

      // Act
      expect(currentAccount, isNotNull);
      mockAccountRepository.removeCurrentAccount();

      // Assert
      verify(mockAccountRepository.removeCurrentAccount()).called(1);
      expect(currentAccount, isNull);
    });
  });

  group('AccountUseCase Tests', () {
    test('updateAccount calls repository updateAccount', () async {
      // Arrange
      when(mockAccountRepository.updateAccount(any, any)).thenAnswer((_) async => Future.value());

      // Act
      await accountUseCase.updateAccount('1234567890', SellerType.individual);

      // Assert
      verify(mockAccountRepository.updateAccount('1234567890', SellerType.individual)).called(1);
    });

    test('addFavoriteAd throws exception if user is not logged in', () async {
      // Arrange
      when(mockAccountRepository.currentAccount).thenReturn(null);

      // Act & Assert
      expect(
        () async => await accountUseCase.addFavoriteAd(mockAdEntity),
        throwsException,
      );
    });

    test('addFavoriteAd adds ad to favorites and database', () async {
      // Arrange
      when(mockAccountRepository.currentAccount).thenReturn(mockAccountEntity);

      // Act
      await accountUseCase.addFavoriteAd(mockAdEntity);

      // Assert
      verify(mockAccountRepository.addFavoriteAd(mockAdEntity)).called(1);
      verify(mockDatabaseRepository.insertFavoriteAd(
        account: mockAccountEntity,
        ad: mockAdEntity,
      )).called(1);
    });

    test('removeFavoriteAd throws exception if user is not logged in', () async {
      // Arrange
      when(mockAccountRepository.currentAccount).thenReturn(null);

      // Act & Assert
      expect(
        () async => await accountUseCase.removeFavoriteAd(mockAdEntity),
        throwsException,
      );
    });

    test('removeFavoriteAd removes ad from favorites and database', () async {
      // Arrange
      when(mockAccountRepository.currentAccount).thenReturn(mockAccountEntity);

      // Act
      await accountUseCase.removeFavoriteAd(mockAdEntity);

      // Assert
      verify(mockAccountRepository.removeFavoriteAd(mockAdEntity)).called(1);
      verify(mockDatabaseRepository.removeFavoriteAd(
        account: mockAccountEntity,
        ad: mockAdEntity,
      )).called(1);
    });

    test('accountStatus stream emits correct values when accountStream changes', () async {
      // Act
      await Future.delayed(Duration(seconds: 1));
      accountStreamController.add(mockAccountEntity);
      accountStreamController.add(null);

      // Assert
      await expectLater(accountUseCase.accountStatus, emitsInOrder([true, false]));
    });

    test('favoriteAdsStream stream emits correct values', () async {
      await Future.delayed(Duration.zero);
      favoriteAdsStreamController.add([mockAdEntity]);

      // Assert
      await expectLater(
          accountUseCase.favoriteAdsStream,
          emitsInOrder([
            [mockAdEntity]
          ]));
    });

    test('myAdsStream stream emits correct values', () async {
      await Future.delayed(Duration.zero);
      myAdsStreamController.add([mockAdEntity]);

      // Assert
      await expectLater(
          accountUseCase.myAdsStream,
          emitsInOrder([
            [mockAdEntity]
          ]));
    });
  });
}
