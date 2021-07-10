class FavoriteCoin{
  String email;
  String coin;
  FavoriteCoin({required this.coin, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'coin': coin,
    };
  }
}
