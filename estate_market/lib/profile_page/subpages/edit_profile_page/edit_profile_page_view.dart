import 'package:domain/entities/account_entity.dart';
import 'package:estate_market/profile_page/subpages/edit_profile_page/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/translate_enums.dart';
import '../../../widgets/custom_textfield.dart';

class EditProfilePageView extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final EditProfileBloc editProfileBloc = EditProfileBloc();
  EditProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editProfile),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phone number field:
            Text(
              AppLocalizations.of(context)!.phoneNumber,
            ),
            BlocListener<EditProfileBloc, EditProfileState>(
              bloc: editProfileBloc,
              listenWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
              listener: (context, state) {
                _phoneNumberController.text = state.phoneNumber;
              },
              child: CustomTextfield(
                controller: _phoneNumberController,
                onChanged: (phoneNumber) => {
                  editProfileBloc.add(ChangePhoneNumberEvent(phoneNumber: phoneNumber)),
                },
              ),
            ),
            const SizedBox(height: 16.0),

            // Type of account
            Text(AppLocalizations.of(context)!.typeOfSeller),

            BlocBuilder<EditProfileBloc, EditProfileState>(
              bloc: editProfileBloc..add(InitProfileEvent()),
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(sellerTypeTranslate(SellerType.individual, context)),
                      leading: Radio<SellerType>(
                        value: SellerType.individual,
                        groupValue: state.sellerType,
                        onChanged: (sellerType) {
                          editProfileBloc.add(ChangeSellerTypeEvent(sellerType: sellerType!));
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(sellerTypeTranslate(SellerType.company, context)),
                      leading: Radio<SellerType>(
                        value: SellerType.company,
                        groupValue: state.sellerType,
                        onChanged: (sellerType) {
                          editProfileBloc.add(ChangeSellerTypeEvent(sellerType: sellerType!));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),

            // Save button:
            PlatformTextButton(
              onPressed: () {
                editProfileBloc.add(SaveChangesEvent());
                Navigator.pop(context);
              },
              material: (context, platform) => _getMaterialTextButtonData(context, platform),
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }

  _getMaterialTextButtonData(BuildContext context, PlatformTarget target) {
    return MaterialTextButtonData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
