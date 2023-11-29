import 'package:flutter_app_book/core/use_cases/book_use_case_imp.dart';
import 'package:flutter_app_book/data/models/book.dart';
import 'package:flutter_app_book/data/repositories/preferences_repository.dart';
import 'package:flutter_app_book/ui/providers/book_entity_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';


class MockBookUseCase extends Mock implements IBookUseCase {}

class MockPreferencesRepository extends Mock implements IPreferencesRepository {}

void main() {
  late MockBookUseCase mockUseCase;
  late MockPreferencesRepository mockPreferencesRepository;
  late BookEntityProvider provider;

  setUp(() {
    mockUseCase = MockBookUseCase();
    mockPreferencesRepository = MockPreferencesRepository();
    provider = BookEntityProvider(mockUseCase, mockPreferencesRepository);
  });

  test('should toggle favorite status and persist in preferences', () async {
    // Arrange
    const bookId = 1;
    final initialBooks = [
      Book(id: bookId, title: 'Book 1', author: 'Author 1', coverUrl: '', downloadUrl: '', isFavorite: false)
    ];

    // Configurando o valor de retorno para getBooks
    when(() => mockUseCase.getBooks()).thenAnswer((_) async => initialBooks);

    // Configurando o valor de retorno para setFavoriteStatus
    when(() => mockPreferencesRepository.setFavoriteStatus(bookId, any())).thenAnswer((_) async {});

    // Garantindo que a lista de livros esteja inicializada
    await provider.loadBooks();

    // Act
    await provider.toggleFavorite(bookId);

    // Assert
    expect(provider.entity.books.first.isFavorite, isTrue);

    verify(() => mockUseCase.getBooks()).called(2);
    verify(() => mockPreferencesRepository.setFavoriteStatus(bookId, true)).called(1);
  });
}
