class LoginModel {
  String? name;
  String? mail;
  String? password;
  bool? keepOn;

  LoginModel({this.name, this.mail, this.password, this.keepOn});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mail = json['mail'];
    password = json['password'];
    keepOn = json['keepOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =
        <String, dynamic>{}; //new Map<String, dynamic>();
    data['name'] = name; //this.name;
    data['mail'] = mail;
    data['password'] = password;
    data['keepOn'] = keepOn;
    return data;
  }

  @override
  String toString() {
    // ignore: prefer_interpolation_to_compose_strings
    return "Name: " + name! + "\nE-mail: " + mail! + "\nPassword: " + password!;
  }
}
