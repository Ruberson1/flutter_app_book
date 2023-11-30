import 'package:dio/dio.dart';
import 'package:flutter_app_book/src/books/core/repositories/i_book_repository.dart';
import 'package:flutter_app_book/src/books/data/models/book.dart';
import 'package:flutter_app_book/src/books/data/repositories/book_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockDio extends Mock implements Dio {}

void main() {
  late Dio mockDio;
  late IBookRepository repository;

  setUp(() {
    mockDio = MockDio();
    repository = BookRepositoryImp(mockDio);
  });

  test('should get a list of books from the API', () async {
    // Arrange
    final response = Response(
      data: [
        {
          "id": 1,
          "title": "The Bible of Nature",
          "author": "Oswald, Felix L.",
          "cover_url": "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
          "download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"
        },
        {
          "id": 2,
          "title": "Kazan",
          "author": "Curwood, James Oliver",
          "cover_url": "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg",
          "download_url": "https://www.gutenberg.org/ebooks/72127.epub.images"
        }
      ],
      statusCode: 200,
      requestOptions: RequestOptions(path: 'your_api_endpoint/books'),
    );

    when(() => mockDio.get('https://escribo.com/books.json')).thenAnswer((_) async => response);

    // Act
    final result = await repository.getBooks();

    // Assert
    expect(result, hasLength(2));
    expect(result[0], isA<Book>());
    expect(result[1], isA<Book>());
    expect(result[0].id, equals(1));
    expect(result[1].id, equals(2));
    verify(() => mockDio.get('https://escribo.com/books.json')).called(1);
  });
}
