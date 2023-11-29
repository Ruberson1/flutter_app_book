// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Book extends Equatable{
    final int id;
    final String title;
    final String author;
    final String coverUrl;
    final String downloadUrl;
    bool isFavorite;

        Book({
        required this.id,
        required this.title,
        required this.author,
        required this.coverUrl,
        required this.downloadUrl,
        this.isFavorite = false
    });

    Book copyWith({
        int? id,
        String? title,
        String? author,
        String? coverUrl,
        String? downloadUrl,
        bool? isFavorite
    }) => 
        Book(
            id: id ?? this.id,
            title: title ?? this.title,
            author: author ?? this.author,
            coverUrl: coverUrl ?? this.coverUrl,
            downloadUrl: downloadUrl ?? this.downloadUrl,
            isFavorite: isFavorite ?? this.isFavorite
        );

    factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
        downloadUrl: json["download_url"],
        isFavorite: false
    );

    void toggleFavorite() {
    isFavorite = !isFavorite;
  }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "cover_url": coverUrl,
        "download_url": downloadUrl,
    };
    
      @override
      List<Object?> get props => [id, title, author, coverUrl, downloadUrl, isFavorite];
}
