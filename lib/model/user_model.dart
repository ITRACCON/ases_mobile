// модель текущего пользователя для будущего запроса профиля
class User {
  String username;
  String email;
  String image;

  User(
      {this.username,
      this.email,
      this.image,
      });

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
      username: data['username'],
      email: data['email'],
      image: data['image']
     );

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "email": this.email,
        "image": this.image,
      };
}
