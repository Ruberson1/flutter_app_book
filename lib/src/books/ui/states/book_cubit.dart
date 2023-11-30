// Estados do Cubit
import '../../data/models/book.dart';

abstract class BookState {}

class LoadingState extends BookState {}

class LoadedState extends BookState {
  final List<Book> books;

  LoadedState(this.books);
}

class ErrorState extends BookState {
  final String error;

  ErrorState(this.error);
}