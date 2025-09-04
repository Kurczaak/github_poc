import 'package:equatable/equatable.dart';
import 'package:github_poc/domain/model/user.dart';

class Repository extends Equatable {
  const Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.description,
    required this.stargazersCount,
    required this.forksCount,
    required this.language,
    required this.htmlUrl,
    required this.updatedAt,
    required this.owner,
  });

  final int id;
  final String name;
  final String fullName;
  final String description;
  final int stargazersCount;
  final int forksCount;
  final String language;
  final String htmlUrl;
  final DateTime updatedAt;
  final User owner;

  @override
  List<Object?> get props => [
    id,
    name,
    fullName,
    description,
    stargazersCount,
    forksCount,
    language,
    htmlUrl,
    updatedAt,
    owner,
  ];
}
