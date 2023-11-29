// book_repository.dart

import 'package:dio/dio.dart';

import '../../core/entities/book_entity.dart';
import '../../core/repositories/i_book_repository.dart';


class BookRepositoryImp implements IBookRepository {
  final Dio dio;

  BookRepositoryImp(this.dio);

  @override
  Future<List<Book>> getBooks() async {
    try {
      final response = await dio.get('your_api_endpoint/books');
      final List<dynamic> data = response.data;
      return data.map((json) => Book.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load books');
    }
  }
}
