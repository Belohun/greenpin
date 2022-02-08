import 'package:greenpin/domain/user/model/address.dart';
import 'package:greenpin/domain/user/model/role.dart';

class UserInfo {
  const UserInfo({
    required this.email,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.address,
    required this.roles,
  });

  final String email;
  final String name;
  final String surname;
  final String phoneNumber;
  final List<Role> roles;
  final List<Address> address;
}
