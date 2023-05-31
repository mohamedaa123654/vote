

class User {
  final String name;
  final String email;
  final String image;
  final bool verification;

  User(this.name, this.email, this.image, this.verification);

  factory User.fromJson(jsonData) {
    return User(
      jsonData['name'],
      jsonData['user'],
      jsonData['image'],
      jsonData['verification'],
    );
  }
}
