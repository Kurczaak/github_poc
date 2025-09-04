import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.login,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.type,
  });

  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;
  final String type;

  @override
  List<Object?> get props => [
    id,
    login,
    avatarUrl,
    htmlUrl,
    type,
  ];
}
