import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/book.dart';
import '../cubit/book_cubit.dart';
import '../states/book_states.dart';
import 'book_details_page.dart';

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is LoadedState) {
            final favoriteBooks =
                state.books.where((book) => book.isFavorite).toList();

            if (favoriteBooks.isNotEmpty) {
              return ListView.builder(
                itemCount: favoriteBooks.length,
                itemBuilder: (context, index) {
                  final book = favoriteBooks[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(book.coverUrl),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {
                        _navigateToBookDetails(context, book);
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No favorite books yet.'),
              );
            }
          } else if (state is ErrorState) {
            return Text('Error: ${state.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _navigateToBookDetails(BuildContext context, Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book: book),
      ),
    );
  }
}
