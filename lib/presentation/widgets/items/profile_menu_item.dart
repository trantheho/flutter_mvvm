import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconAsset;
  final String text;
  final bool switchMode;
  final Function()? onTap;
  final Function(BuildContext, bool)? onSwitchChanged;

  const ProfileMenuItem({
    super.key,
    required this.iconAsset,
    required this.text,
    this.onTap,
  })  : onSwitchChanged = null,
        switchMode = false;

  const ProfileMenuItem.switchMode({
    super.key,
    required this.iconAsset,
    required this.text,
    this.onSwitchChanged,
  })  : onTap = null,
        switchMode = true;

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
            if (!switchMode)
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
