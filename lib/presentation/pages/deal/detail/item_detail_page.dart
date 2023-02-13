import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/utils/app_utils.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/presentation/providers/product_provider.dart';
import 'package:flutter_mvvm/presentation/providers/shopping_cart_provider.dart';
import 'package:flutter_mvvm/presentation/widgets/rating_overview.dart';
import 'package:flutter_mvvm/presentation/widgets/tab_bar_view/description_tab.dart';
import 'package:flutter_mvvm/presentation/widgets/tab_bar_view/review_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/quantity_count.dart';

class ItemDetailPage extends StatefulWidget {
  final ProductModel product;

  const ItemDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: appController.helper.statusBarOverlayUI(Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: widget.product.name,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(widget.product.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 20,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ProductInfo(product: widget.product),
              ],
            ),
            buildBackButton(),
          ],
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: context.popRoute,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductInfo extends StatefulWidget {
  final ProductModel product;

  const ProductInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final ValueNotifier<int> productQuantity = ValueNotifier(1);
  int totalQuantity = 1;

  @override
  void dispose() {
    productQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FRUITS',
                style: AppTextStyle.medium.copyWith(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.product.name,
                style: AppTextStyle.medium.copyWith(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.priceString,
                    style: AppTextStyle.medium.copyWith(
                      fontSize: 24,
                      color: AppColors.lightYellow,
                    ),
                  ),
                  QuantityCount(
                    itemCountChange: (count) {
                      productQuantity.value = count;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const RatingOverview(),
              const SizedBox(height: 32.0),
              const InformationOverview(),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Consumer(
                    builder: (_, ref, __) {
                      final trendingProduct = ref.read(trendingProductProvider.notifier);

                      return HeartButton(
                        active: widget.product.favorite,
                        onFavoriteChanged: (value) => trendingProduct.setFavorite(widget.product.id, value),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final shoppingCart = ref.read(shoppingCartProvider.notifier);

                      return Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.lightYellow,
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: InkWell(
                            onTap: () => handleAddProduct(context, shoppingCart),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Add to cart'.toUpperCase(),
                                  style: AppTextStyle.medium.copyWith(
                                    fontSize: 16.0,
                                  ),
                                ),
                                ValueListenableBuilder<int>(
                                  valueListenable: productQuantity,
                                  builder: (_, quantity, __) {
                                    totalQuantity = quantity;
                                    final price = (widget.product.price * quantity).toStringAsFixed(1);

                                    return Text(
                                      '\$$price',
                                      style: AppTextStyle.medium,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleAddProduct(BuildContext context, ShoppingCartProvider shoppingCart) {
    shoppingCart.addNewProduct(widget.product, totalQuantity);
    appController.toast.showToast(
      context: context,
      message: "Add to cart",
    );
  }
}

class HeartButton extends StatefulWidget {
  final bool active;
  final Function(bool)? onFavoriteChanged;

  const HeartButton({Key? key, this.active = false, this.onFavoriteChanged}) : super(key: key);

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  late bool active;

  @override
  void initState() {
    super.initState();
    active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 93,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: AppColors.green,
      ),
      child: InkWell(
        onTap: favoriteChange,
        child: Center(
          child: Icon(
            CupertinoIcons.heart_fill,
            color: active ? AppColors.pink : Colors.white,
          ),
        ),
      ),
    );
  }

  void favoriteChange() {
    setState(() {
      active = !active;
      widget.onFavoriteChanged!(active);
    });
  }
}

class InformationOverview extends StatefulWidget {
  const InformationOverview({Key? key}) : super(key: key);

  @override
  State<InformationOverview> createState() => _InformationOverviewState();
}

class _InformationOverviewState extends State<InformationOverview> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            overlayColor: MaterialStateProperty.resolveWith((states) => Colors.grey),
            padding: EdgeInsets.zero,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: AppTextStyle.medium.copyWith(fontSize: 18),
            unselectedLabelStyle: AppTextStyle.normal.copyWith(fontSize: 18),
            labelColor: Colors.black,
            indicatorColor: AppColors.lightYellow,
            tabs: const [
              Text('Description'),
              Text(
                'Review',
              ),
              Text(
                'Disscussion',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 300,
          width: double.maxFinite,
          child: TabBarView(
            controller: tabController,
            children: const [
              DescriptionTab(),
              //DescriptionTab(),
              ReviewTab(),
              DescriptionTab(),
            ],
          ),
        ),
      ],
    );
  }
}
