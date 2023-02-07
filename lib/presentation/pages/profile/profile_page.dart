import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/manager/app_state_manager.dart';
import 'package:flutter_mvvm/core/manager/locale_manager.dart';
import 'package:flutter_mvvm/core/manager/theme_manager.dart';
import 'package:flutter_mvvm/core/router/app_router.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/app_bar.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
import 'package:flutter_mvvm/presentation/widgets/items/profile_menu_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: MyAppBar(
        title: Text(
          'My Profile',
          style: context.theme.textTheme.displayLarge!.copyWith(fontSize: 20),
        ),
        backgroundColor: context.theme.backgroundColor,
      ),
      body: Container(
        color: context.theme.backgroundColor,
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const ProfileInfo(),
            const SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
              ),
              child: ProfileMenuItem.switchMode(
                iconAsset: AppImages.icDarkMode,
                text: 'Dark mode',
                onSwitchChanged: (switchContext, darkMode) => switchContext.appState.updateTheme(
                  darkMode ? ThemeMode.light : ThemeMode.dark,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
              ),
              child: ProfileMenuItem(
                iconAsset: AppImages.icSetting,
                text: 'Setting',
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
              ),
              child: ProfileMenuItem(
                iconAsset: AppImages.icStatistic,
                text: 'Statistic',
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
                right: 28.0,
              ),
              child: ProfileMenuItem(
                iconAsset: AppImages.icLogout,
                text: 'Logout',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeMode(AppState appState) {
    appState.updateTheme(appState.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
    appState.updateLocale(Locale(appState.locale.languageCode == 'vi' ? 'en' : 'vi'));
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = context.appState.currentUser!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 100.0,
          backgroundColor: Colors.teal,
          child: CircleAvatar(
            maxRadius: 98.0,
            minRadius: 70.0,
            foregroundImage: AssetImage(AppImages.avatar),
          ),
        ),
        const SizedBox(
          height: 18.0,
        ),
        Text(
          userInfo.name,
          style: context.theme.textTheme.displayLarge!.copyWith(
            fontSize: 20.0,
          ),
        ),
        Text(
          userInfo.email,
          style: context.theme.textTheme.displaySmall!.copyWith(
            color: context.theme.bottomAppBarTheme.color,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
