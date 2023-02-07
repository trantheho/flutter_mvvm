import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_enum.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/generated/l10n.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconAsset;
  final String text;
  final bool switchMode;
  final bool dropDown;
  final Function()? onTap;
  final Function(BuildContext, bool)? onSwitchChanged;
  final Function(BuildContext, AppLanguage)? onLanguageChanged;
  final List<AppLanguage> languages;

  ProfileMenuItem({
    super.key,
    required this.iconAsset,
    required this.text,
    this.onTap,
  })  : onSwitchChanged = null,
        onLanguageChanged = null,
        switchMode = false,
        dropDown = false,
        languages = [];

  ProfileMenuItem.switchMode({
    super.key,
    required this.iconAsset,
    required this.text,
    this.onSwitchChanged,
  })  : onTap = null,
        onLanguageChanged = null,
        switchMode = true,
        dropDown = false,
        languages = [];

  const ProfileMenuItem.locale({
    super.key,
    required this.iconAsset,
    required this.text,
    required this.languages,
    this.onLanguageChanged,
  })  : onTap = null,
        switchMode = false,
        dropDown = true,
        onSwitchChanged = null;

  @override
  Widget build(BuildContext context) {
    final darkMode = context.appState.themeMode == ThemeMode.light ? false : true;
    final theme = context.theme;

    return InkWell(
      onTap: switchMode ? null : onTap,
      splashColor: Colors.black12,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              iconAsset,
              width: 24,
              height: 24,
              color: theme.iconTheme.color,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                text,
                style: context.theme.textTheme.displaySmall?.copyWith(
                  fontSize: 16.0,
                ),
              ),
            ),
            if (switchMode) _buildSwitchButton(context, darkMode),
            if (dropDown) _buildDropDown(context, theme),
            if (!switchMode && !dropDown)
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: theme.iconTheme.color,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDown(BuildContext context, ThemeData theme) {
    final value = languages.firstWhere(
      (e) => e.code == context.appState.locale.languageCode,
      orElse: () => AppLanguage.vietnamese,
    );

    return DropdownButton<AppLanguage>(
      value: value,
      icon: Icon(Icons.arrow_drop_down_outlined, color: theme.iconTheme.color,),
      elevation: 16,
      style: AppTextStyle.medium.copyWith(color: theme.primaryColorLight,),
      onChanged: (language) => onLanguageChanged != null ? onLanguageChanged!(context, language!) : null,
      items: languages.map((e) {
        String asset = '';
        String text = '';
        switch (e) {
          case AppLanguage.vietnamese:
            asset = AppImages.icVietnamese;
            text = S.of(context).vietnamese;
            break;
          case AppLanguage.english:
            asset = AppImages.icEnglish;
            text = S.of(context).english;
            break;
        }

        return DropdownMenuItem<AppLanguage>(
          value: e,
          child: Row(
            children: [
              Image.asset(asset),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                text,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSwitchButton(BuildContext context, bool darkMode) {
    return Switch(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: AppColors.orange,
      activeTrackColor: Colors.orange,
      inactiveThumbColor: AppColors.greyLight,
      value: darkMode,
      onChanged: (_) => onSwitchChanged != null ? onSwitchChanged!(context, darkMode) : null,
    );
  }
}
