import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/manager/app_state_manager.dart';
import 'package:flutter_mvvm/core/manager/locale_manager.dart';
import 'package:flutter_mvvm/core/manager/theme_manager.dart';
import 'package:flutter_mvvm/core/router/app_router.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/widgets/button.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (builderContext) {
                debugPrint('text theme builder');
                return Text(
                  S.of(builderContext).profile,
                  style: AppTextStyle.bold.copyWith(
                    fontSize: 22,
                    color: builderContext.theme.primaryColor,
                  ),
                );
              },
            ),
            Builder(
              builder: (builderContext) {
                return AppButton(
                  onPressed: () => changeMode(builderContext.appState),
                  buttonText: 'Change',
                );
              },
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
