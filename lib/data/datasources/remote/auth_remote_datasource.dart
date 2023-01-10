import 'package:flutter_mvvm/data/datasources/local/hive_storage.dart';
import 'package:flutter_mvvm/data/datasources/remote/api/dio_client.dart';
import 'package:flutter_mvvm/domain/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider((ref) {
  final dioClient = DioClient(HiveStorage.instance);

  return AuthRemoteDataSource(dioClient);
});


class AuthRemoteDataSource{
  final DioClient dioClient;
  AuthRemoteDataSource(this.dioClient);


  Future<UserModel> login({required String email, required String password}) async {
    //final url = '${dioClient.baseApi}/login';
    //final option = await dioClient.getOptions();
    //final response = await dioClient.dioCall(() => dioClient.dio.get(url, options: option));
    final Map<String, dynamic> json = {
      "name": "test",
      "age": "20",
      "email": "test@gmail.com",
    };
    final data = await Future.delayed(const Duration(seconds: 2)).then((value) => json);

    return UserModel.fromJson(data);
  }
}