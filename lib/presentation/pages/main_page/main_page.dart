import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:go_router/go_router.dart';

enum MainTab {
  home('/home'),
  category('/category'),
  cart('/cart'),
  favorite('/favorite'),
  profile('/profile');

  const MainTab(this.path);

  final String path;
}

class MainPage extends StatefulWidget {
  final Widget child;

  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: Builder(builder: (barContext) {
          final theme = barContext.theme;

          return BottomNavigationBar(
            backgroundColor: theme.bottomAppBarColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: theme.primaryColor,
            unselectedItemColor: AppColors.grey177,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _item(
                tab: MainTab.home,
                theme: theme,
              ),
              _item(
                tab: MainTab.category,
                theme: theme,
              ),
              _item(
                tab: MainTab.cart,
                theme: theme,
              ),
              _item(
                tab: MainTab.favorite,
                theme: theme,
              ),
              _item(
                tab: MainTab.profile,
                theme: theme,
              ),
            ],
            currentIndex: _currentIndex,
            onTap: _tapBottomBar,
          );
        }),
      ),
    );
  }

  void _tapBottomBar(int index) {
    String path = MainTab.home.path;
    if (index == 0) path = MainTab.home.path;
    if (index == 1) path = MainTab.category.path;
    if (index == 2) path = MainTab.cart.path;
    if (index == 3) path = MainTab.favorite.path;
    if (index == 4) path = MainTab.profile.path;

    if (index != _currentIndex) context.go(path);
  }

  int getIndexFromTab(MainTab tab) {
    switch (tab) {
      case MainTab.home:
        return 0;
      case MainTab.category:
        return 1;
      case MainTab.cart:
        return 2;
      case MainTab.favorite:
        return 3;
      case MainTab.profile:
        return 4;
      default:
        return 0;
    }
  }

  int _locationToTabIndex(String location) {
    final index = MainTab.values.indexWhere((tab) => location.startsWith(tab.path));
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  BottomNavigationBarItem _item({
    required MainTab tab,
    required ThemeData theme,
  }) {
    String icon;
    switch (tab) {
      case MainTab.home:
        icon = AppImages.icHome;
        break;
      case MainTab.category:
        icon = AppImages.icTransfer;
        break;
      case MainTab.cart:
        icon = AppImages.icShoppingCart;
        break;
      case MainTab.favorite:
        icon = AppImages.icHeart;
        break;
      default:
        icon = AppImages.icHome;
        break;
    }

    if (tab == MainTab.profile) {
      return BottomNavigationBarItem(
        icon: CircleAvatar(
          radius: 12.0,
          backgroundColor:
              _currentIndex == MainTab.profile.index ? AppColors.orange : theme.bottomAppBarTheme.color,
          child: const CircleAvatar(
            maxRadius: 10.0,
            minRadius: 10.0,
            foregroundImage: AssetImage(AppImages.avatar),
          ),
        ),
        label: '',
      );
    }

    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        color: theme.bottomAppBarTheme.color,
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        icon,
        color: AppColors.orange,
      ),
      label: '',
    );
  }
}
