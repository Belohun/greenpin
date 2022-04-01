class UserToken {
  UserToken({
    required this.refreshToken,
    required this.token,
  });

  final String token;
  final String refreshToken;

  String get header => 'Bearer $token';
}
