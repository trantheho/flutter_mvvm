import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/core/router/route_config.dart';
import 'package:flutter_mvvm/core/utils/styles.dart';
import 'package:flutter_mvvm/domain/models/category_model.dart';
import 'package:flutter_mvvm/presentation/pages/deal/deal_page.dart';
import 'package:flutter_mvvm/presentation/widgets/items/category_item.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_utils.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final categories = [
    CategoryModel(
      imageUrl: AppImages.icFruit,
      title: "Fruits",
      itemCount: 87,
    ),
    CategoryModel(
      imageUrl: AppImages.icVegetable,
      title: "Vegetables",
      itemCount: 87,
    ),
    CategoryModel(
      imageUrl: AppImages.icMushroom,
      title: "Mushroom",
      itemCount: 87,
    ),
    CategoryModel(
      imageUrl: AppImages.icDairy,
      title: "Dairy",
      itemCount: 87,
    ),
    CategoryModel(
      imageUrl: AppImages.icOat,
      title: "Oats",
      itemCount: 87,
    ),
    CategoryModel(
      imageUrl: AppImages.icBread,
      title: "Bread",
      itemCount: 27,
    ),
    CategoryModel(
      imageUrl: AppImages.icRice,
      title: "Rice",
      itemCount: 27,
    ),
    CategoryModel(
      imageUrl: AppImages.icEgg,
      title: "Egg",
      itemCount: 120,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Categories',
          style: AppTextStyle.medium.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              padding: const EdgeInsets.all(38),
              itemCount: categories.length,
              itemBuilder: (_, index) {
                return CategoryItem.withName(
                  item: categories[index],
                  active: false,
                  onTap: () => toDealPage(categories[index].title!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryItemWithOpenContainer(int index){
    return OpenContainer(
      routeSettings: RouteSettings(
        name: AppPage.deal.name,
      ),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
      ),
      closedElevation: 0.0,
      openElevation: 2.0,
      closedColor: Colors.transparent,
      middleColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 350),
      closedBuilder: (_, openContainer) {
        return CategoryItem.withName(
          item: categories[index],
          active: false,
          onTap: (){
            openContainer();
          },
        );
      },
      openBuilder: (_, __) {
        return DealPage(title: categories[index].title!,);
      },
    );
  }

  void toDealPage(String type){
    context.goNamed(AppPage.deal.name, params: {AppPage.deal.params!: type.toLowerCase()});
  }
}
