import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_helper.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/presentation/widgets/app_text_form_field.dart';
import 'package:flutter_mvvm/presentation/widgets/input.dart';
import 'package:flutter_mvvm/presentation/widgets/items/product_item.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_controller.dart';
import '../../../core/utils/app_utils.dart';
import '../../widgets/my_flexible_space_bar.dart';

class DealPage extends StatefulWidget {
  final String title;
  const DealPage({Key? key, this.title = ''}) : super(key: key);

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> with SingleTickerProviderStateMixin{
  final _titleKey = GlobalKey(debugLabel: 'title');
  final double expandedTitleScale = 1.2;
  final ScrollController controller = ScrollController();

  final products = [
    ProductModel(
      id: 1,
      imageUrl: AppImages.avocado,
      name: "Avocado",
      price: 6.7,
      priceString: r"$6.7",
      favorite: true,
      productType: 'fruits',
    ),
    ProductModel(
      id: 2,
      imageUrl: AppImages.brocoli,
      name: "Brocoli",
      price: 8.7,
      priceString: "\$8.7",
      favorite: false,
      productType: 'fruits',
    ),
    ProductModel(
      id: 3,
      imageUrl: AppImages.tomatoes,
      name: "Tomatoes",
      price: 4.9,
      priceString: r"$4.9",
      favorite: false,
      productType: 'fruits',
    ),
    ProductModel(
      id: 4,
      imageUrl: AppImages.grapes,
      name: "Grapes",
      price: 7.2,
      priceString: r"$7.2",
      favorite: false,
      productType: 'fruits',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        controller: controller,
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              expandedHeight: 222.0,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 1.0,
              automaticallyImplyLeading: false,
              flexibleSpace: MyFlexibleSpaceBar(
                expandedTitleScale: expandedTitleScale,
                titleBuilder: (settings, constraints, t){
                  return _buildToolBar(settings, constraints, t);
                },
                stretchModes: const [StretchMode.fadeTitle, StretchMode.blurBackground,],
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                background: Container(
                  color: AppColors.lightYellow,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SearchHeaderDelegate(
                minHeight: 88.0,
                maxHeight: 88.0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                  ),
                  child: const Center(
                    child: Search(),
                  ),
                ),
              ),
            ),
          ];
        },
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            childAspectRatio: 150 / 199,
          ),
          padding: const EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 28.0,),
          itemCount: products.length,
          itemBuilder: (_, index) {
            return ProductItem(
              product: products[index],
              onTap: () => toDetail(products[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToolBar(FlexibleSpaceBarSettings settings, BoxConstraints constraints, double t){
    double verticalPadding = 16.0;
    final titleWidth = getTitleWidth();
    final width = constraints.maxWidth/2 - titleWidth/2;
    final left = clampDouble((verticalPadding * t) + width* t, 0, width);
    final bottom = getBottom(verticalPadding, t);
    final opacity = getOpacity(settings, constraints, t);
    final top = clampDouble((1.0 - t) * kToolbarHeight/2, 0, kToolbarHeight/2);

    return Stack(
      children: [
        //bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: opacity,
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
            ),
          ),
        ),
        //title
        Positioned(
          left: left,
          bottom: bottom + (1.0 - t)*26.0,
          child: AnimatedOpacity(
            opacity: clampDouble(opacity, 1, 1),
            duration: const Duration(milliseconds: 0),
            child: Padding(
              padding: EdgeInsets.only(left: (1.0-t) * 28.0, bottom: (1.0-t) * 20.0 + 16.0),
              child: Text(
                '${widget.title.upperCaseFirst} Category',
                key: _titleKey,
                style: AppTextStyle.bold.copyWith(
                  fontSize: 20,
                  color: Color.lerp(Colors.white, Colors.black, t),//opacity == 0 ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
        // item count
        Positioned(
          left: left,
          bottom: bottom + (1.0 - t)*46,
          child: Padding(
            padding: EdgeInsets.only(left: (1.0-t) * 28.0,),
            child: AnimatedScale(
            scale: 1.0 - t,
            duration: const Duration(milliseconds: 0),
            child: Text(
              '87 Items',
              style: AppTextStyle.normal.copyWith(
                fontSize: 14,
                color: opacity == 0 ? Colors.black : Colors.white,
              ),
            ),
        ),
          ),
        ),
        //leading
        Positioned(
          left: 0,
          top: top,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4.0).copyWith(left: 12),
              child: IconButton(
                onPressed: context.popRoute,
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.lerp(Colors.white, Colors.black, t),
                ),
                iconSize: 24,
              ),
            ),
          ),
        ),
        //actions
        Positioned(
          right: 0,
          top: top,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4.0).copyWith(left: 12),
              child: IconButton(
                onPressed: null,
                icon: Image.asset(
                  AppImages.icFilter,
                  color: Color.lerp(Colors.white, Colors.black, t),//opacity == 0 ? Colors.black : Colors.white,
                ),
                iconSize: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  double getTitleWidth(){
    final RenderBox? box = _titleKey.currentContext?.findRenderObject() as RenderBox?;
    if(box != null){
      return box.size.width;
    }
    return 0;
  }

  double getTitleHeight(){
    final RenderBox? box = _titleKey.currentContext?.findRenderObject() as RenderBox?;
    if(box != null){
      return box.size.height;
    }
    return 0;
  }

  double getBottom(double verticalPadding, double t) => verticalPadding == 0
      ? verticalPadding * t + 16.0 * t
      : clampDouble(verticalPadding * t + 16.0 * t, 0, (1.0 - t) * 16.0);

  double getOpacity(FlexibleSpaceBarSettings settings, BoxConstraints constraints, double t){
    final double deltaExtent = settings.maxExtent - settings.minExtent;
    final double fadeStart = max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    const double fadeEnd = 1.0;
    assert(fadeStart <= fadeEnd);
    // If the min and max extent are the same, the app bar cannot collapse
    // and the content should be visible, so opacity = 1.
    final double opacity = settings.maxExtent == settings.minExtent
        ? 1.0
        : 1.0 - Interval(fadeStart, fadeEnd).transform(t);

    return opacity;
  }

  void toDetail(ProductModel product) {
    context.pushNamed(
        AppPage.detail.name,
        extra: product,
        params: {
          AppPage.deal.params!: widget.title.toLowerCase(),
          AppPage.detail.params!: product.name.toLowerCase(),
        },
    );
  }
}

class SearchHeaderDelegate extends SliverPersistentHeaderDelegate{
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SearchHeaderDelegate({required this.minHeight, required this.child, required this.maxHeight,});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SearchHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: AppColors.whiteGrey,
      ),
      //padding: const EdgeInsets.fromLTRB(0.0, 8.0, 18.0, 8.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 8.0, 18.0, 8.0),
        child: Row(
          children: [
            Expanded(
              child: AppInput.text(
                hintText: 'Search here',
                hintStyle: AppTextStyle.normal.copyWith(
                  fontSize: 16,
                  color: AppColors.greyLight,
                ),
                style: AppTextStyle.normal.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.search,
              color: AppColors.greyLight,
            ),
          ],
        ),
      ),
    );
  }
}

