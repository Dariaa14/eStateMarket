import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'register_page_bloc.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPageBloc bloc = RegisterPageBloc();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: min(MediaQuery.of(context).size.width - 60, 450),
                  height: MediaQuery.of(context).size.height / 1.25,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 70,
                          height: 60,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    bloc.add(ChangeRegisterTypeEvent(type: RegisterPageType.login));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: (state.registerPageType == RegisterPageType.login)
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    bloc.add(ChangeRegisterTypeEvent(type: RegisterPageType.signup));
                                  },
                                  child: Text(
                                    "Signup",
                                    style: TextStyle(
                                        color: (state.registerPageType == RegisterPageType.signup)
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Username textfield:
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                                child: PlatformTextField(
                                  maxLines: 1,
                                  hintText: "Username",
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Password textfield:
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 40,
                              child: TextField(
                                obscureText: state.isPasswordObscured,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  contentPadding: const EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      bloc.add(ChangePasswordVisibilityEvent());
                                    },
                                    icon: Icon(
                                      (state.isPasswordObscured == true)
                                          ? CupertinoIcons.eye
                                          : CupertinoIcons.eye_slash,
                                      size: 20,
                                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            if (state.registerPageType == RegisterPageType.signup)
                              const SizedBox(
                                height: 10,
                              ),

                            // Password strenght indicator:
                            if (state.registerPageType == RegisterPageType.signup)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password strenght: ",
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                  const Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PasswordStrenghtContainer(
                                          colored: Colors.red,
                                        ),
                                        PasswordStrenghtContainer(
                                          colored: Colors.orange,
                                        ),
                                        PasswordStrenghtContainer(
                                          colored: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            // Stay connected checkbox
                            if (state.registerPageType == RegisterPageType.login)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                      value: state.isStayConnectedChecked,
                                      onChanged: (isChecked) {
                                        bloc.add(ChangeStayConnectedEvent());
                                      }),
                                  Text(
                                    "Stay Connected",
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text((state.registerPageType == RegisterPageType.login) ? "Login" : "Signup"),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}

class PasswordStrenghtContainer extends StatelessWidget {
  final Color colored;

  const PasswordStrenghtContainer({super.key, required this.colored});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: colored,
      ),
      width: (min(MediaQuery.of(context).size.width - 80, 430) - 150) / 3,
      height: 10,
    );
  }
}
