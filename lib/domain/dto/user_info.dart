import '/domain/enums/enums.dart';
import '/domain/models/user.dart';

class UserInfo {
  final String id;
  final String name;
  final String contact;
  final Positions position;

  UserInfo({
    required this.id,
    required this.name,
    required this.contact,
    required this.position,
  });

  factory UserInfo.fromUser(User user) {
    return UserInfo(
      id: user.id!,
      name: user.name,
      contact: user.contact,
      position: user.position,
    );
  }
}
