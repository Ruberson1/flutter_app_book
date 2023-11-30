import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/book.dart';
import '../cubit/book_cubit.dart';
import '../states/book_states.dart';
import 'book_details_page.dart';
import 'favorite_books_page.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late BookCubit _bookCubit;

  @override
  void initState() {
    super.initState();
    _bookCubit = context.read<BookCubit>();
    _bookCubit.loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escribo livros'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteBooksPage(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            return ListView.builder(
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];
                return SingleChildScrollView(
                  child: Card(
                    child: ListTile(
                      leading: Image.network(book.coverUrl),
                      title: Text(book.title),
                      subtitle: Text(book.author),
                      onTap: () {
                        _navigateToBookDetails(context, book);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorState) {
            return Text('Error: ${state.error}');
          } else {
            return Container(); // Trate outros estados conforme necessário
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

  @override
  void dispose() {
    _bookCubit.close();
    super.dispose();
  }
}


