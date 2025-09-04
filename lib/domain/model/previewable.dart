import 'package:equatable/equatable.dart';

abstract class Previewable extends Equatable {
  const Previewable({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.url,
  });

  final int id;
  final String title;
  final String subtitle;
  final String author;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String state;
  final String url;

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    author,
    createdAt,
    updatedAt,
    state,
    url,
  ];
}
