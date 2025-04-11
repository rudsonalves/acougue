import '/domain/models/user.dart';

class UserInfo {
  final String id;
  final String name;
  final String contact;

  UserInfo({required this.id, required this.name, required this.contact});

  factory UserInfo.fromUser(User user) {
    return UserInfo(id: user.id!, name: user.name, contact: user.contact);
  }
}
