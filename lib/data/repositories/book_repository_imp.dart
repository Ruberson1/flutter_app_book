// book_repository.dart

import 'package:dio/dio.dart';

import '../../core/repositories/i_book_repository.dart';
import '../models/book.dart';


class BookRepositoryImp implements IBookRepository {
  final Dio dio;

  BookRepositoryImp(this.dio);

  @override
  Future<List<Book>> getBooks() async {
    try {
      final response = await dio.get('https://escribo.com/books.json');
      final List<dynamic> data = response.data;
      return data.map((json) => Book.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to load books');
    }
  }
}
