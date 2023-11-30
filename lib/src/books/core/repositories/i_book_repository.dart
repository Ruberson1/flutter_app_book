import '../../data/models/book.dart';

abstract class IBookRepository {
  Future<List<Book>> getBooks();
}
