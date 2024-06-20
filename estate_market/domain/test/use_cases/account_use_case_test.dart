import 'dart:async';

import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:domain/use_cases/account_use_case.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../mocks_generator.mocks.dart';

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

    test('dispose closes all stream controllers', () async {
      // Act
      accountUseCase.dispose();

      // Assert
      expect(accountUseCase.areControllersClosed(), true);
    });
  });
}
