import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/fetch_category_usecase.dart';

class CategoryViewModel extends StateNotifier{

  final FetchCategoryUseCase fetchCategoryUseCase;

  CategoryViewModel(this.fetchCategoryUseCase) : super(null);

}