// book_use_case.dart


import '../entities/book_entity.dart';
import '../repositories/i_book_repository.dart';

abstract class IBookUseCase {
  Future<List<Book>> getBooks();
}

class BookUseCaseImp implements IBookUseCase {
  final IBookRepository repository;

  BookUseCaseImp(this.repository);

  @override
  Future<List<Book>> getBooks() async {
    return await repository.getBooks();
  }
}
