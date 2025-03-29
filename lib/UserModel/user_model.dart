class Usermodel {
  final String id;
  final String name;
  final String password;
  final String url;

  Usermodel(
      {required this.id,
        required this.name,
        required this.password,
        required this.url});

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['user'],
      password: json['password'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': name,
      'password': password,
      'url': url,
    };
  }
}
