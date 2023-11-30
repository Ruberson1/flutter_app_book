import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/book.dart';
import '../cubit/book_cubit.dart';
import 'favorite_books_page.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(book.coverUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.author,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      book.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: book.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      context.read<BookCubit>().toggleFavorite(book.id);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoriteBooksPage(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: _launchUrl,
                    child: const Text('Download'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(book.downloadUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
