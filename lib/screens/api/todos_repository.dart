import 'package:dio/dio.dart';
import 'package:flutter_theme/screens/domain/todos_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: TodosRepository)
class HttpMovieRepository implements TodosRepository {
  HttpMovieRepository(
    this._dio,
  );
  final Dio _dio;
}
