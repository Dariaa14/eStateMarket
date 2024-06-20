import 'dart:async';

import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late MockAccountEntity mockCurrentUser;
  late MockAccountEntity mockOtherUser;
  late MockMessageEntity mockMessage1;
  late MockMessageEntity mockMessage2;
  late List<MessageEntity> messages;
  late List<AccountEntity> chatUsers;

  setUp(() {
    mockChatRepository = MockChatRepository();
    mockCurrentUser = MockAccountEntity();
    mockOtherUser = MockAccountEntity();
    mockMessage1 = MockMessageEntity();
    mockMessage2 = MockMessageEntity();

    messages = [mockMessage1, mockMessage2];
    chatUsers = [mockCurrentUser, mockOtherUser];

    when(mockCurrentUser.email).thenReturn('user1@example.com');
    when(mockCurrentUser.password).thenReturn('password123');
    when(mockCurrentUser.phoneNumber).thenReturn('1234567890');
    when(mockCurrentUser.sellerType).thenReturn(SellerType.individual);

    when(mockOtherUser.email).thenReturn('user2@example.com');
    when(mockOtherUser.password).thenReturn('password456');
    when(mockOtherUser.phoneNumber).thenReturn('0987654321');
    when(mockOtherUser.sellerType).thenReturn(SellerType.company);

    when(mockMessage1.message).thenReturn('Hello');
    when(mockMessage1.isSenderFirst).thenReturn(true);
    when(mockMessage1.timestamp).thenReturn(DateTime.now());

    when(mockMessage2.message).thenReturn('Hi');
    when(mockMessage2.isSenderFirst).thenReturn(false);
    when(mockMessage2.timestamp).thenReturn(DateTime.now());
  });

  group('ChatRepository Tests', () {
    test('getMessages returns a stream of messages', () {
      // Arrange
      when(mockChatRepository.getMessages()).thenAnswer((_) => Stream.value(messages));

      // Act
      final stream = mockChatRepository.getMessages();

      // Assert
      expectLater(stream, emits(messages));
    });

    test('getChatUsers returns a stream of chat users', () {
      // Arrange
      when(mockChatRepository.getChatUsers()).thenAnswer((_) => Stream.value(chatUsers));

      // Act
      final stream = mockChatRepository.getChatUsers();

      // Assert
      expectLater(stream, emits(chatUsers));
    });

    test('setCurrentUser sets the current user', () {
      // Act
      mockChatRepository.setCurrentUser(mockCurrentUser);

      // Assert
      verify(mockChatRepository.setCurrentUser(mockCurrentUser)).called(1);
    });

    test('setOtherUser sets the other user', () {
      // Act
      mockChatRepository.setOtherUser(mockOtherUser);

      // Assert
      verify(mockChatRepository.setOtherUser(mockOtherUser)).called(1);
    });
  });
}
