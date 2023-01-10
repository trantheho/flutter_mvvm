import 'package:flutter_mvvm/domain/repository/product_repository/product_repository.dart';

import '../models/product_model.dart';

class FetchCategoryUseCase{
  final ProductRepository productRepository;

  FetchCategoryUseCase(this.productRepository);


  Future<List<ProductModel>> run(String category) async {

    return await productRepository.fetchCategory(category);
  }
}