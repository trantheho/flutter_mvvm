import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/app_controller.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/app_assets.dart';
import 'package:flutter_mvvm/core/utils/app_helper.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/category_model.dart';
import 'package:flutter_mvvm/domain/models/product_model.dart';
import 'package:flutter_mvvm/domain/models/recommend_product.dart';
import 'package:flutter_mvvm/generated/l10n.dart';
import 'package:flutter_mvvm/presentation/providers/product_provider.dart';
import 'package:flutter_mvvm/presentation/widgets/items/category_item.dart';
import 'package:flutter_mvvm/presentation/widgets/items/product_item.dart';
import 'package:flutter_mvvm/presentation/widgets/items/recommend_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final recommendProducts = [
    RecommendProductModel(title: "Recomended", description: "Recipe Today", asset: AppImages.recommendRecipe,),
    RecommendProductModel(title: "Fresh Fruits", description: "Delivery", asset: AppImages.recommendDelivery,),
    RecommendProductModel(title: "Recomended", description: "Recipe Today", asset: AppImages.recommendRecipe,),
    RecommendProductModel(title: "Fresh Fruits", description: "Delivery", asset: AppImages.recommendDelivery,),
  ];

  final categories = [
    CategoryModel(imageUrl: AppImages.icFruit,),
    CategoryModel(imageUrl: AppImages.icMushroom,),
    CategoryModel(imageUrl: AppImages.icOat,),
    CategoryModel(imageUrl: AppImages.icRice,),
    CategoryModel(imageUrl: AppImages.icVegetable,),
    CategoryModel(imageUrl: AppImages.icDairy,),
    CategoryModel(imageUrl: AppImages.icBread,),
    CategoryModel(imageUrl: AppImages.icEgg,),
  ];

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
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.dark),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 10,),
              const UserInfo(),
              const SizedBox(height: 23,),
              Recommend(recommendProducts: recommendProducts),
              const SizedBox(height: 30,),
              Categories(categories: categories),
              const SizedBox(height: 26,),
              Expanded(child: Trending(products: products,),),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: AppTextStyle.medium.copyWith(
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: () => toCategory(context),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
        const SizedBox(height: 13,),
        SizedBox(
          height: 73,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            itemCount: categories.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CategoryItem(
                  item: categories[index],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4,),
      ],
    );
  }

  void toCategory(BuildContext context){
    context.go(AppPage.category.path);
  }
}

class Recommend extends StatelessWidget {
  const Recommend({
    Key? key,
    required this.recommendProducts,
  }) : super(key: key);

  final List<RecommendProductModel> recommendProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 162,
      width: double.infinity,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: recommendProducts.length,
        padding: const EdgeInsets.symmetric(horizontal: 28.0,),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20,),
            child: RecommendItem(item: recommendProducts[index]),
          );
        },
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning',
                style: AppTextStyle.normal,
              ),
              const SizedBox(height: 4,),
              Text(
                'TiTi',
                style: AppTextStyle.bold.copyWith(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0,),
            child: Image.asset(AppImages.icNotification),
          ),
        ],
      ),
    );
  }
}

class Trending extends StatelessWidget {
  final List<ProductModel> products;
  const Trending({Key? key, required this.products,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Trending Deals",
                style: AppTextStyle.medium.copyWith(
                  fontSize: 18,
                ),
              ),
              IconButton(
                onPressed: () => toDealPage(context),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          const SizedBox(height: 13,),
          Expanded(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final trendingProducts = ref.watch(trendingProductProvider);

                return trendingProducts.when(
                  data: (products) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 150 / 199,
                      ),
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        return ProductItem(
                          product: products[index],
                        );
                      },
                    );
                  },
                  error: (_, __) => const Text('no product'),
                  loading: () => const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void toDealPage(BuildContext context){

  }
}

