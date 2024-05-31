import 'package:estate_market/config/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'conversations_page_bloc.dart';

class ConversationsPageView extends StatelessWidget {
  const ConversationsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final ConversationsPageBloc conversationsBloc = ConversationsPageBloc();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: BlocBuilder<ConversationsPageBloc, ConversationsPageState>(
        bloc: conversationsBloc..add(InitConversationsPageEvent()),
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  title: Text('Chat with ${state.users[index].email}'),
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.chatPage, arguments: state.users[index]);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          );
        },
      ),
    );
  }
}
