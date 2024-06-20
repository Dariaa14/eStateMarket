import 'dart:async';

import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/ad_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockAccountRepository mockAccountRepository;
  late AccountEntity mockAccountEntity;
  late AdEntity mockAdEntity;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    mockAccountEntity = MockAccountEntity();
    mockAdEntity = MockAdEntity();
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
}
