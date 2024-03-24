import 'package:domain/entities/account_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../create_ad_page/widgets/create_ad_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/translate_enums.dart';

class EditProfilePageView extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  EditProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
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
            CreateAdTextfield(
              hintText: 'current phone',
              controller: _phoneNumberController,
              onChanged: (phoneNumber) => {},
            ),
            const SizedBox(height: 16.0),

            // Type of account
            Text(AppLocalizations.of(context)!.typeOfSeller),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(sellerTypeTranslate(SellerType.individual, context)),
                  leading: Radio<SellerType>(
                    value: SellerType.individual,
                    groupValue: null,
                    onChanged: (sellerType) {},
                  ),
                ),
                ListTile(
                  title: Text(sellerTypeTranslate(SellerType.company, context)),
                  leading: Radio<SellerType>(
                    value: SellerType.company,
                    groupValue: null,
                    onChanged: (sellerType) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Save button:
            PlatformTextButton(
              onPressed: () {},
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
