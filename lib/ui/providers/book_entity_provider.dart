// book_entity_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_app_book/core/use_cases/book_use_case_imp.dart';
import 'package:flutter_app_book/data/repositories/preferences_repository.dart';

import '../../core/entities/book_entity.dart';


class BookEntityProvider extends ChangeNotifier {
  final IBookUseCase useCase;
  final IPreferencesRepository preferencesRepository;
  late BookEntity _entity;
  BookEntity get entity => _entity;

  BookEntityProvider(this.useCase, this.preferencesRepository) {
    _entity = BookEntity([]);
    loadBooks();
  }

  Future<void> loadBooks() async {
    final books = await useCase.getBooks();
    _entity = BookEntity(books);
    notifyListeners();
  }

  Future<void> toggleFavorite(int bookId) async {
    final book = _entity.books.firstWhere((b) => b.id == bookId);
    book.toggleFavorite();

    await preferencesRepository.setFavoriteStatus(bookId, book.isFavorite);
    notifyListeners();
  }
}
