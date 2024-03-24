import 'dart:math';

import 'package:domain/errors/register_errors.dart';
import 'package:estate_market/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'register_page_bloc.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPageBloc bloc = RegisterPageBloc();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
      bloc: bloc,
      builder: (context, state) {
        return BlocListener<RegisterPageBloc, RegisterPageState>(
          bloc: bloc,
          listener: (context, state) {
            if (state.wasLoginSuccessful) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
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
                          Navigator.pop(context);
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
                          Image.asset(
                            'assets/app_logo/logo_with_title.png',
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Change pages between login/signup
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _emailController.text = '';
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
                                      _emailController.text = '';
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

                              // Email textfield:
                              CustomTextField(
                                hintText: AppLocalizations.of(context)!.email,
                                controller: _emailController,
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
                                            colored: (state.passwordStrenght.index >= 3) ? Colors.yellow : Colors.grey,
                                          ),
                                          PasswordStrenghtContainer(
                                            colored: (state.passwordStrenght.index >= 4) ? Colors.lime : Colors.grey,
                                          ),
                                          PasswordStrenghtContainer(
                                            colored: (state.passwordStrenght.index >= 5) ? Colors.green : Colors.grey,
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
                            onPressed: () {
                              if (state.registerPageType == RegisterPageType.signup) {
                                bloc.add(CreateAccountEvent(
                                    email: _emailController.text, password: _passwordController.text));
                                // Navigator.pop(context);
                              } else {
                                bloc.add(LoginEvent(email: _emailController.text, password: _passwordController.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: (state.isLoading)
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary),
                                  )
                                : Text((state.registerPageType == RegisterPageType.login)
                                    ? AppLocalizations.of(context)!.login
                                    : AppLocalizations.of(context)!.signup),
                          ),

                          Text(
                            _errorMessage(state, context),
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _errorMessage(RegisterPageState state, BuildContext context) {
    if (state.failure == null) {
      return '';
    } else if (state.failure is EmailAlreadyInUse) {
      return AppLocalizations.of(context)!.usedEmail;
    } else if (state.failure is InvalidEmail) {
      return AppLocalizations.of(context)!.invalidEmail;
    } else if (state.failure is PasswordTooWeak) {
      return AppLocalizations.of(context)!.passwordTooWeak;
    } else if (state.failure is PasswordTooShort) {
      return AppLocalizations.of(context)!.passwordTooShort;
    } else if (state.failure is InvalidCredential) {
      return AppLocalizations.of(context)!.invalidCredential;
    } else if (state.failure is MissingEmail) {
      return AppLocalizations.of(context)!.missingEmail;
    } else if (state.failure is MissingPassword) {
      return AppLocalizations.of(context)!.missingPassword;
    } else if (state.failure is NetworkRequestFailed) {
      return AppLocalizations.of(context)!.networkRequestFailure;
    } else {
      return 'unknown error';
    }
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
      width: (min(MediaQuery.of(context).size.width - 80, 430) - 150) / 5,
      height: 10,
    );
  }
}
