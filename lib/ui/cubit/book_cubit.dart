

import 'package:bloc/bloc.dart';

import '../../core/use_cases/book_use_case_imp.dart';
import '../states/book_states.dart';

// abstract interface class BookEvent {}

// class LoadBooksEvent extends BookEvent {}

// class ToggleFavoriteEvent extends BookEvent {
//   final int bookId;

//   ToggleFavoriteEvent(this.bookId);
// }

class BookCubit extends Cubit<BookState> {
  final IBookUseCase useCase;

  BookCubit(this.useCase) : super(LoadingState());

  Future<void> loadBooks() async {
    emit(LoadingState());
    try {
      final books = await useCase.getBooks();
      emit(LoadedState(books));
    } catch (e) {
      emit(ErrorState('Failed to load books: $e'));
    }
  }

  Future<void> toggleFavorite(int bookId) async {
    try {
      final books = (state as LoadedState).books.map((book) {
        if (book.id == bookId) {
          book.toggleFavorite();
        }
        return book;
      }).toList();
      emit(LoadedState(books));
    } catch (e) {
      emit(ErrorState('Failed to toggle favorite: $e'));
    }
  }
}
