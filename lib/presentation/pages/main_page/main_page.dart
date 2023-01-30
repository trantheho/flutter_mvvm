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
  const MainPage({Key? key, required this.child,}) : super(key: key);

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.theme.primaryColor,
          unselectedItemColor: AppColors.grey177,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _item(MainTab.home),
            _item(MainTab.category),
            _item(MainTab.cart),
            _item(MainTab.favorite),
            _item(MainTab.profile),
          ],
          currentIndex: _currentIndex,
          onTap: _tapBottomBar,
        ),
      ),
    );
  }

  void _tapBottomBar(int index) {
    String path = MainTab.home.path;
    if(index == 0) path = MainTab.home.path;
    if(index == 1) path = MainTab.category.path;
    if(index == 2) path = MainTab.cart.path;
    if(index == 3) path = MainTab.favorite.path;
    if(index == 4) path = MainTab.profile.path;

    if(index != _currentIndex) context.go(path);
  }

  int getIndexFromTab(MainTab tab){
    switch(tab){
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

  BottomNavigationBarItem _item(MainTab tab){
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

    return BottomNavigationBarItem(
      icon: Image.asset(icon, color: AppColors.grey177,),
      activeIcon: Image.asset(icon, color: context.theme.primaryColor,),
      label: '',
    );
  }
}
