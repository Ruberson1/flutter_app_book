import 'package:bloc/bloc.dart';
import '../../data/repositories/preferences_repository.dart';
import '../states/book_states.dart';
import '../../core/use_cases/book_use_case_imp.dart';

class BookCubit extends Cubit<BookState> {
  final IBookUseCase useCase;
  final IPreferencesRepository preferencesRepository;

  BookCubit(this.useCase, this.preferencesRepository) : super(LoadingState());

  Future<void> loadBooks() async {
    emit(LoadingState());
    try {
      final books = await useCase.getBooks();
      final favoriteIds = await _getFavoriteBookIds();

      final booksWithFavorites = books.map((book) {
        if (favoriteIds.contains(book.id)) {
          book.isFavorite = true;
        }
        return book;
      }).toList();

      emit(LoadedState(booksWithFavorites));
    } catch (e) {
      emit(ErrorState('Failed to load books: $e'));
    }
  }

  Future<List<int>> _getFavoriteBookIds() async {
    // Obter os IDs dos livros favoritados a partir do repositório de preferências
    final favoriteIds = await preferencesRepository.getFavoriteBookIds();
    return favoriteIds;
  }

  Future<void> toggleFavorite(int bookId) async {
    try {
      final books = (state as LoadedState).books.map((book) {
        if (book.id == bookId) {
          book.toggleFavorite();

          // Salvar ou remover o ID do livro favoritado no repositório de preferências
          final isFavorite = book.isFavorite;
          if (isFavorite) {
            preferencesRepository.addFavoriteBookId(bookId);
          } else {
            preferencesRepository.removeFavoriteBookId(bookId);
          }
        }
        return book;
      }).toList();
      emit(LoadedState(books));
    } catch (e) {
      emit(ErrorState('Failed to toggle favorite: $e'));
    }
  }
}
