import '../entities/book_entity.dart';

abstract class IBookRepository {
  Future<List<Book>> getBooks();
}
