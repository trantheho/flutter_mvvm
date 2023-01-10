import 'package:flutter_mvvm/domain/models/user_model.dart';

class ReviewModel{
  final UserModel userModel;
  final DateTime reviewDate;
  final String title;
  final int rating;
  final String message;

  ReviewModel({
    required this.userModel,
    required this.title,
    required this.rating,
    required this.message,
    required this.reviewDate,
  });
}