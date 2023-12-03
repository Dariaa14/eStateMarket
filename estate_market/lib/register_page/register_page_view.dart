import 'dart:math';

import 'package:estate_market/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'register_page_bloc.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPageBloc bloc = RegisterPageBloc();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                child: Stack(children: [
                  // Return to previous page button
                  Positioned(
                    left: 5.0,
                    top: 5.0,
                    child: IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/app_logo/logo_with_title.png'),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Change pages between login/signup
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _usernameController.text = '';
                                    _passwordController.text = '';
                                    bloc.add(ChangeRegisterTypeEvent(type: RegisterPageType.login));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
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
                                    _usernameController.text = '';
                                    _passwordController.text = '';
                                    bloc.add(ChangeRegisterTypeEvent(type: RegisterPageType.signup));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.signup,
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
                            CustomTextField(
                              hintText: AppLocalizations.of(context)!.username,
                              controller: _usernameController,
                              prefix: Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            // Password textfield:
                            CustomTextField(
                              controller: _passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              obscureText: state.isPasswordObscured,
                              onChanged: (password) => {bloc.add(CalculatePasswordStrenghtEvent(password: password))},
                              prefix: Icon(
                                Icons.password,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              suffix: IconButton(
                                onPressed: () {
                                  bloc.add(ChangePasswordVisibilityEvent());
                                },
                                icon: Icon(
                                  (state.isPasswordObscured == true) ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                                    AppLocalizations.of(context)!.password_strength,
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PasswordStrenghtContainer(
                                          colored: (state.passwordStrenght.index >= 1) ? Colors.red : Colors.grey,
                                        ),
                                        PasswordStrenghtContainer(
                                          colored: (state.passwordStrenght.index >= 2) ? Colors.orange : Colors.grey,
                                        ),
                                        PasswordStrenghtContainer(
                                          colored: (state.passwordStrenght.index >= 3) ? Colors.green : Colors.grey,
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
                                    AppLocalizations.of(context)!.stay_connected,
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        // Login/Signup button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text((state.registerPageType == RegisterPageType.login)
                              ? AppLocalizations.of(context)!.login
                              : AppLocalizations.of(context)!.signup),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
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
