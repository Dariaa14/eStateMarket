import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'login_page_bloc.dart';

class LoginPage extends StatelessWidget {
  final LoginPageBloc bloc = LoginPageBloc();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPageBloc, LoginPageState>(
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
                            Text(
                              "Login",
                              style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 18),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Username textfield:
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                borderRadius: BorderRadius.circular(20.0),
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
                                borderRadius: BorderRadius.circular(20.0),
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
                            )
                          ],
                        ),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text("Login"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("sign up tap");
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                  ),
                                )
                              ],
                            ),
                          ],
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
