import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/modules/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/color_pallette.dart';

class ProfileView extends StatefulWidget {

   ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
@override
  void initState() {
    super.initState();
  }
final List<String> _languages = [
  "English",
  "العربية"
];
final List<String> _themes = [
  "Light",
  "Dark"
];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var local = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(65)
            ),
            color: theme.primaryColor,
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16,
              children: [
            Container(
                height: 125,
                width: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(1000),
                  bottomLeft: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
                  image: DecorationImage(image: AssetImage(Assets.profileImg))
              ),
            ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ismaeil Sherif",style: theme.textTheme.headlineSmall),
                    Text("Flutter Developer",style: theme.textTheme.titleMedium),
                  ],
                )
          ]
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(local.language,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: provider.isDark()? Colors.white : Colors.black
          ),),
        ),
        SizedBox(height: 12),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16),child:
        CustomDropdown<String>(
          items: _languages,
          initialItem: provider.currentLanguage == "en" ? "English" : "العربية",
          onChanged: (value) {
            log('changing value to: $value');
            provider.changeLanguage(value! == "English" ? "en" : "ar");
          },
          decoration: CustomDropdownDecoration(
            closedBorder: Border.all(
              color: theme.primaryColor
            ),
            closedSuffixIcon: Icon(Icons.keyboard_arrow_down_sharp, size: 30,color: theme.primaryColor,),
            closedFillColor: Colors.transparent,
            headerStyle: theme.textTheme.titleLarge?.copyWith(
              color: theme.primaryColor
            )
          ),
        ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(local.theme_mode,
            style: theme.textTheme.headlineSmall?.copyWith(
                color: provider.isDark()? Colors.white : Colors.black
            ),),
        ),
        SizedBox(height: 12),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16),child:
        CustomDropdown<String>(
          items: _themes,
          initialItem: provider.isDark() ? "Dark" : "Light",
          onChanged: (value) {
            log('changing value to: $value');
            provider.changeTheme(value! == "Light" ? ThemeMode.light : ThemeMode.dark);
          },
          decoration: CustomDropdownDecoration(
              closedBorder: Border.all(
                  color: theme.primaryColor
              ),
              closedSuffixIcon: Icon(Icons.keyboard_arrow_down_sharp, size: 30,color: theme.primaryColor,),
              closedFillColor: Colors.transparent,
              headerStyle: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor
              )
          ),
        ),
        ),
      ],
    );
  }
}
