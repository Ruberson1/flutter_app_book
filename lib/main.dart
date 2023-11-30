import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_book/src/books/core/repositories/i_book_repository.dart';
import 'package:flutter_app_book/src/books/core/use_cases/book_use_case_imp.dart';
import 'package:flutter_app_book/src/books/data/repositories/book_repository_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/books/ui/cubit/book_cubit.dart';
import 'src/books/ui/pages/book_page.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(create: (ctx) => Dio()),

        RepositoryProvider<IBookRepository>(
          create: (ctx) => BookRepositoryImp(ctx.read<Dio>()),
        ),

        RepositoryProvider<IBookUseCase>(
          create: (ctx) => BookUseCaseImp(ctx.read<IBookRepository>()),
        ),

        BlocProvider<BookCubit>(
          create: (ctx) => BookCubit(ctx.read<IBookUseCase>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.purple,
        ),
        home: const BookPage(),
      ),
    );
  }
}
