import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/manager/locale_manager.dart';
import 'package:flutter_mvvm/core/router/app_router.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
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
    debugPrint('profile');
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).profile,
            style: AppTextStyle.bold.copyWith(fontSize: 22, color: Colors.black,),
          ),
          Consumer(
            builder: (_, ref, __) {
              final languageCode = ref.watch(localeProvider);
              final localeMG = ref.read(localeProvider.notifier);

              return AppButton(
                onPressed: () => localeMG.updateLocale(Locale(languageCode.languageCode == 'vi' ? 'en' : 'vi')),
                buttonText: 'Change',
              );
            },
          ),
        ],
      ),
    ),);
  }
}