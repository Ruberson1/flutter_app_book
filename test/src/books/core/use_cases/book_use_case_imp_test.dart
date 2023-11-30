import 'package:flutter_app_book/src/books/core/repositories/i_book_repository.dart';
import 'package:flutter_app_book/src/books/core/use_cases/book_use_case_imp.dart';
import 'package:flutter_app_book/src/books/data/models/book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockBookRepository extends Mock implements IBookRepository {}

void main() {
  late IBookRepository mockRepository;
  late IBookUseCase useCase;

  setUp(() {
    mockRepository = MockBookRepository();
    useCase = BookUseCaseImp(mockRepository);
  });

  test('should get a list of books from the repository', () async {
    // Arrange
    final books = [
      Book(id: 1, title: 'Book 1', author: 'Author 1', coverUrl: '', downloadUrl: ''),
      Book(id: 2, title: 'Book 1', author: 'Author 1', coverUrl: '', downloadUrl: '', isFavorite: true),
    ];

    when(() => mockRepository.getBooks()).thenAnswer((_) async => books);

    // Act
    final result = await useCase.getBooks();

    // Assert
    expect(result, equals(books));
    verify(() => mockRepository.getBooks()).called(1);
  });
}
