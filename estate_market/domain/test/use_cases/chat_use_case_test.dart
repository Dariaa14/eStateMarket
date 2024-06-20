import 'package:domain/entities/account_entity.dart';
import 'package:domain/entities/message_entity.dart';
import 'package:domain/use_cases/chat_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../mocks_generator.mocks.dart';

void main() {
  late MockChatRepository mockChatRepository;
  late MockAccountEntity mockCurrentUser;
  late MockAccountEntity mockOtherUser;
  late MockMessageEntity mockMessage1;
  late MockMessageEntity mockMessage2;
  late List<MessageEntity> messages;
  late List<AccountEntity> chatUsers;
  late ChatUseCase chatUseCase;

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

    when(mockChatRepository.getMessages()).thenAnswer((_) => Stream.fromIterable([messages]));
    when(mockChatRepository.getChatUsers()).thenAnswer((_) => Stream.fromIterable([chatUsers]));

    chatUseCase = ChatUseCase(chatRepository: mockChatRepository);
  });

  tearDown(() {
    chatUseCase.dispose();
  });

  group('ChatUseCase Tests', () {
    test('messagesStream emits messages from repository', () async {
      // Assert
      await expectLater(chatUseCase.messagesStream, emits(messages));
    });

    test('usersStream emits chat users from repository', () async {
      // Assert
      await expectLater(chatUseCase.usersStream, emits(chatUsers));
    });

    test('setCurrentUser sets the current user in repository', () {
      // Act
      chatUseCase.setCurrentUser(mockCurrentUser);

      // Assert
      verify(mockChatRepository.setCurrentUser(mockCurrentUser)).called(1);
    });

    test('setOtherUser sets the other user in repository', () {
      // Act
      chatUseCase.setOtherUser(mockOtherUser);

      // Assert
      verify(mockChatRepository.setOtherUser(mockOtherUser)).called(1);
    });

    test('dispose closes all stream controllers', () async {
      // Act
      chatUseCase.dispose();

      // Assert
      expect(chatUseCase.areControllersClosed(), true);
    });
  });
}
