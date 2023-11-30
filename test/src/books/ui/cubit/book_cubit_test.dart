import 'package:flutter_app_book/src/books/core/use_cases/book_use_case_imp.dart';
import 'package:flutter_app_book/src/books/data/models/book.dart';
import 'package:flutter_app_book/src/books/data/repositories/preferences_repository.dart';
import 'package:flutter_app_book/src/books/ui/cubit/book_cubit.dart';
import 'package:flutter_app_book/src/books/ui/states/book_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class BookUseCaseImpMock extends Mock implements IBookUseCase {}

class SharedPreferencesMock extends Mock implements IPreferencesRepository {}

void main() {
  late BookUseCaseImpMock bookUseCase = BookUseCaseImpMock();
  late BookCubit cubit;
  late IPreferencesRepository shared;
  setUp(() {
    bookUseCase = BookUseCaseImpMock();
    shared = SharedPreferencesMock();
    cubit = BookCubit(bookUseCase, shared);
  });

  group('fetch books |', () {
    test('should get all books', () async {
      when(() => bookUseCase.getBooks()).thenAnswer(
        (_) async => [
          Book(
              id: 2,
              title: 'Book 1',
              author: 'Author 1',
              coverUrl: '',
              downloadUrl: '',
              isFavorite: true),
        ],
      );

      expect(
        cubit.stream,
        emitsInOrder([
          isA<LoadingState>(),
          isA<LoadedState>(),
        ]),
      );

      await cubit.loadBooks();
    });
  });
}
