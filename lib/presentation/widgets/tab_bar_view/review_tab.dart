import 'package:flutter/material.dart';
import 'package:flutter_mvvm/domain/models/review_model.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_mvvm/presentation/widgets/items/review_item.dart';



final users = [
  UserModel(name: 'Alex', age: '30', email: 'alex@gmail.com'),
  UserModel(name: 'Lux', age: '30', email: 'lux@gmail.com'),
  UserModel(name: 'Lucian', age: '30', email: 'lucian@gmail.com'),
  UserModel(name: 'Darius', age: '30', email: 'darius@gmail.com'),
  UserModel(name: 'Zig', age: '30', email: 'zig@gmail.com'),
];

final listItem = [
  ReviewModel(userModel: users[0], title: "App too bad", rating: 1, message: 'message', reviewDate: DateTime.now()),
  ReviewModel(userModel: users[1], title: "App okay", rating: 2, message: 'message', reviewDate: DateTime.now()),
  ReviewModel(userModel: users[2], title: "App ok", rating: 3, message: 'message', reviewDate: DateTime.now()),
  ReviewModel(userModel: users[3], title: "App too lag", rating: 2, message: 'message', reviewDate: DateTime.now()),
];

class ReviewTab extends StatelessWidget {
  const ReviewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 82,),
      itemCount: listItem.length,
      itemBuilder: (BuildContext context, int index) {
        return ReviewItem(item: listItem[index]);
      },
    );
  }
}
