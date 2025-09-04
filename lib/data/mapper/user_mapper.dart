import 'package:github_poc/data/dto/user_dto.dart';
import 'package:github_poc/domain/model/user.dart';

extension UserDtoExtension on UserDto {
  User toDomainModel() {
    return User(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      htmlUrl: htmlUrl,
      type: type,
    );
  }
}
